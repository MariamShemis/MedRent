import 'package:med_rent/features/booking_reservation_doctor/data/models/reservation_details_model.dart';
import '../models/reservation_model.dart';

abstract class BookingReservationState {}

class BookingReservationInitial extends BookingReservationState {}

class BookingReservationLoading extends BookingReservationState {}

class BookingReservationSuccess extends BookingReservationState {
  final List<ReservationModel> bookings;

  BookingReservationSuccess(this.bookings);
}

class BookingDetailsLoaded extends BookingReservationState {
  final ReservationDetailsModel details;
  BookingDetailsLoaded(this.details);
}

class BookingReservationError extends BookingReservationState {
  final String message;

  BookingReservationError(this.message);
}
