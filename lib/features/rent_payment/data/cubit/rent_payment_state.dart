import '../models/rental_summary_response.dart';

abstract class RentPaymentState {}

class RentPaymentInitial extends RentPaymentState {}

class RentPaymentLoading extends RentPaymentState {}

class RentPaymentSummaryLoaded extends RentPaymentState {
  final RentalSummaryResponse summary;

  RentPaymentSummaryLoaded({required this.summary});
}

class RentPaymentProcessing extends RentPaymentState {
  final RentalSummaryResponse summary;

  RentPaymentProcessing({required this.summary});
}

class RentPaymentSuccess extends RentPaymentState {
  final String message;

  RentPaymentSuccess({required this.message});
}

class RentPaymentError extends RentPaymentState {
  final String message;
  final RentalSummaryResponse? summary;

  RentPaymentError({required this.message, this.summary});
}
