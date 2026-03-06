// lib/features/booking/presentation/cubit/booking_state.dart

part of 'booking_cubit.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

final class BookingLoading extends BookingState {}

final class HospitalDetailsLoaded extends BookingState {
  final HospitalModel hospital;
  final int selectedDepartmentId;
  final DoctorModel? selectedDoctor;
  final DateTime selectedDate;
  final List<AvailableTimeModel> availableTimes;
  final bool isLoadingTimes;

  HospitalDetailsLoaded({
    required this.hospital,
    required this.selectedDepartmentId,
    this.selectedDoctor,
    required this.selectedDate,
    required this.availableTimes,
    required this.isLoadingTimes,
  });

  HospitalDetailsLoaded copyWith({
    HospitalModel? hospital,
    int? selectedDepartmentId,
    DoctorModel? selectedDoctor,
    DateTime? selectedDate,
    List<AvailableTimeModel>? availableTimes,
    bool? isLoadingTimes,
  }) {
    return HospitalDetailsLoaded(
      hospital: hospital ?? this.hospital,
      selectedDepartmentId: selectedDepartmentId ?? this.selectedDepartmentId,
      selectedDoctor: selectedDoctor ?? this.selectedDoctor,
      selectedDate: selectedDate ?? this.selectedDate,
      availableTimes: availableTimes ?? this.availableTimes,
      isLoadingTimes: isLoadingTimes ?? this.isLoadingTimes,
    );
  }
}

final class BookingError extends BookingState {
  final String message;
  BookingError({required this.message});
}

final class AppointmentBookingSuccess extends BookingState {
  final String message;
  AppointmentBookingSuccess({required this.message});
}