// lib/features/booking/presentation/cubit/booking_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:med_rent/features/booking/data/data_source/booking_data.dart';
import 'package:med_rent/features/booking/data/model/booking_model.dart';
import 'package:meta/meta.dart';


part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingData _bookingData = BookingData();

  BookingCubit() : super(BookingInitial());

  Future<void> loadHospitalDetails() async {
    emit(BookingLoading());
    try {
      final hospital = await _bookingData.getHospitalBookingDetails();
      emit(HospitalDetailsLoaded(
        hospital: hospital,
        selectedDepartmentId: hospital.departments.isNotEmpty 
            ? hospital.departments.first.departmentId 
            : 0,
        selectedDate: DateTime.now(),
        availableTimes: const [],
        isLoadingTimes: false,
      ));
    } catch (e) {
      emit(BookingError(message: e.toString()));
    }
  }

  void selectDepartment(int departmentId) {
    if (state is HospitalDetailsLoaded) {
      final currentState = state as HospitalDetailsLoaded;
      emit(currentState.copyWith(
        selectedDepartmentId: departmentId,
        selectedDoctor: null,
        availableTimes: const [],
      ));
    }
  }

  void selectDoctor(DoctorModel doctor) {
    if (state is HospitalDetailsLoaded) {
      final currentState = state as HospitalDetailsLoaded;
      emit(currentState.copyWith(
        selectedDoctor: doctor,
        availableTimes: const [],
      ));
      loadDoctorAvailableTimes(doctor.doctorId, currentState.selectedDate);
    }
  }

  void selectDate(DateTime date) {
    if (state is HospitalDetailsLoaded) {
      final currentState = state as HospitalDetailsLoaded;
      emit(currentState.copyWith(
        selectedDate: date,
        availableTimes: const [],
      ));
      
      if (currentState.selectedDoctor != null) {
        loadDoctorAvailableTimes(currentState.selectedDoctor!.doctorId, date);
      }
    }
  }

  Future<void> loadDoctorAvailableTimes(int doctorId, DateTime date) async {
    if (state is! HospitalDetailsLoaded) return;

    final currentState = state as HospitalDetailsLoaded;
    emit(currentState.copyWith(isLoadingTimes: true));

    try {
      final times = await _bookingData.getDoctorAvailableTimes(
        doctorId: doctorId,
        date: date,
      );
      
      if (state is HospitalDetailsLoaded) {
        final updatedState = state as HospitalDetailsLoaded;
        emit(updatedState.copyWith(
          availableTimes: times,
          isLoadingTimes: false,
        ));
      }
    } catch (e) {
      if (state is HospitalDetailsLoaded) {
        final updatedState = state as HospitalDetailsLoaded;
        emit(updatedState.copyWith(isLoadingTimes: false));
        emit(BookingError(message: 'Failed to load available times: $e'));
      }
    }
  }

  Future<void> bookAppointment({
    required int doctorId,
    required DateTime date,
    required String time,
  }) async {
    emit(BookingLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(AppointmentBookingSuccess(
        message: 'Appointment booked successfully!'
      ));
    } catch (e) {
      emit(BookingError(message: e.toString()));
    }
  }
}