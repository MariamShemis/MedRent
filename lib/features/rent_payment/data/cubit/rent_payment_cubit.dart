import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:med_rent/features/rent_payment/data/cubit/rent_payment_state.dart';
import 'package:med_rent/features/rent_payment/data/data_sources/rent_payment_data_source.dart';
import 'package:med_rent/features/rent_payment/data/models/rental_summary_response.dart';

class RentPaymentCubit extends Cubit<RentPaymentState> {
  final RentPaymentDataSource _dataSource;

  RentPaymentCubit({required RentPaymentDataSource dataSource})
    : _dataSource = dataSource,
      super(RentPaymentInitial());

  RentalSummaryResponse? _summary;

  Future<void> loadSummary(int rentalId) async {
    emit(RentPaymentLoading());

    try {
      final summary = await _dataSource.getRentalSummary(rentalId);
      _summary = summary;
      emit(RentPaymentSummaryLoaded(summary: summary));
    } catch (e) {
      emit(RentPaymentError(message: e.toString()));
    }
  }

  Future<void> processPayment({
    required int rentalId,
    required String fullName,
    required String phone,
    required String streetAddress,
    required String apartment,
    required String city,
  }) async {
    final currentState = state;
    final summary = currentState is RentPaymentSummaryLoaded
        ? currentState.summary
        : _summary;
    if (summary == null) {
      emit(RentPaymentError(message: "Unexpected Error", summary: summary));
      return;
    }
    emit(RentPaymentProcessing(summary: summary!));

    try {
      // 1. Start checkout → get clientSecret
      final checkout = await _dataSource.startCheckout(
        rentalId: rentalId,
        fullName: fullName,
        phone: phone,
        streetAddress: streetAddress,
        apartment: apartment,
        city: city,
      );

      // 2. Initialize Stripe payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: checkout.clientSecret,
          merchantDisplayName: 'MedRent',
        ),
      );

      // 3. Present Stripe payment sheet (handles card UI)
      await Stripe.instance.presentPaymentSheet();

      // 4. Verify payment on backend
      final result = await _dataSource.verifyPayment(checkout.paymentIntentId);

      emit(RentPaymentSuccess(message: result));
    } on StripeException catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
      if (e.error.code == FailureCode.Canceled) {
        // User cancelled – go back to summary
        emit(RentPaymentSummaryLoaded(summary: summary));
        return;
      }
      emit(
        RentPaymentError(
          message: e.error.localizedMessage ?? 'Payment failed',
          summary: summary,
        ),
      );
    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
      emit(RentPaymentError(message: e.toString(), summary: summary));
    }
  }
}
