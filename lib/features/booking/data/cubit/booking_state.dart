part of 'booking_cubit.dart';

@immutable
abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingError extends BookingState {
  final String message;
  BookingError({required this.message});
}

class BookingSuccessLoaded extends BookingState {
  final HospitalModel hospital;
  final int selectedDepartmentId;
  final DateTime selectedDate;

  BookingSuccessLoaded({
    required this.hospital,
    required this.selectedDepartmentId,
    required this.selectedDate,
  });

  BookingSuccessLoaded copyWith({
    HospitalModel? hospital,
    int? selectedDepartmentId,
    DateTime? selectedDate,
  }) {
    return BookingSuccessLoaded(
      hospital: hospital ?? this.hospital,
      selectedDepartmentId: selectedDepartmentId ?? this.selectedDepartmentId,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

class BookingCreating extends BookingState {}

class BookingCreated extends BookingState {
  final int bookingId;
  BookingCreated({required this.bookingId});
}