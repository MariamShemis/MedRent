import '../models/booking_summary_response.dart';

abstract class BookingPaymentState {}

class BookingPaymentInitial extends BookingPaymentState {}

class BookingPaymentLoading extends BookingPaymentState {}

class BookingPaymentSummaryLoaded extends BookingPaymentState {
  final BookingSummaryResponse summary;

  BookingPaymentSummaryLoaded({required this.summary});
}

class BookingPaymentProcessing extends BookingPaymentState {
  final BookingSummaryResponse summary;

  BookingPaymentProcessing({required this.summary});
}

class BookingPaymentSuccess extends BookingPaymentState {
  final String message;

  BookingPaymentSuccess({required this.message});
}

class BookingPaymentError extends BookingPaymentState {
  final String message;
  final BookingSummaryResponse? summary;

  BookingPaymentError({required this.message, this.summary});
}
