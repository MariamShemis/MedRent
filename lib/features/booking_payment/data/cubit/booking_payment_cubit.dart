import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:med_rent/features/booking_payment/data/cubit/booking_payment_state.dart';
import 'package:med_rent/features/booking_payment/data/data_sources/booking_payment_data_source.dart';
import 'package:med_rent/features/booking_payment/data/models/booking_summary_response.dart';

class BookingPaymentCubit extends Cubit<BookingPaymentState> {
  final BookingPaymentDataSource _dataSource;

  BookingPaymentCubit({required BookingPaymentDataSource dataSource})
    : _dataSource = dataSource,
      super(BookingPaymentInitial());

  BookingSummaryResponse? _summary;

  Future<void> loadSummary(int bookingId) async {
    emit(BookingPaymentLoading());

    try {
      final summary = await _dataSource.getBookingSummary(bookingId);
      _summary = summary;
      emit(BookingPaymentSummaryLoaded(summary: summary));
    } catch (e) {
      emit(BookingPaymentError(message: e.toString()));
    }
  }

  Future<void> processPayment({
    required int bookingId,
    required String patientName,
    required String patientEmail,
    required String patientPhone,
    required String bookingType,
  }) async {
    final currentState = state;
    final summary = currentState is BookingPaymentSummaryLoaded
        ? currentState.summary
        : _summary;
    if (summary == null) {
      emit(BookingPaymentError(message: "Unexpected Error", summary: summary));
      return;
    }
    emit(BookingPaymentProcessing(summary: summary));

    try {
      // 1. Create payment intent → get clientSecret
      final checkout = await _dataSource.createPaymentIntent(bookingId);

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
      final result = await _dataSource.verifyPayment(
        paymentIntentId: checkout.paymentIntentId,
        patientName: patientName,
        patientEmail: patientEmail,
        patientPhone: patientPhone,
        bookingType: bookingType,
      );

      emit(BookingPaymentSuccess(message: result));
    } on StripeException catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
      if (e.error.code == FailureCode.Canceled) {
        // User cancelled – go back to summary
        emit(BookingPaymentSummaryLoaded(summary: summary));
        return;
      }
      emit(
        BookingPaymentError(
          message: e.error.localizedMessage ?? 'Payment failed',
          summary: summary,
        ),
      );
    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
      emit(BookingPaymentError(message: e.toString(), summary: summary));
    }
  }
}
