import 'package:bloc/bloc.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/features/booking/data/data_source/booking_data.dart';
import 'package:med_rent/features/booking/data/model/booking_model.dart';
import 'package:meta/meta.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingData _bookingData;

  BookingCubit(ApiClient apiClient)
    : _bookingData = BookingData(apiClient: apiClient),
      super(BookingInitial());

  Future<void> loadHospitalDetails(int hospitalId) async {
    emit(BookingLoading());
    try {
      final hospital = await _bookingData.getHospitalBookingDetails(hospitalId);
      emit(
        BookingSuccessLoaded(
          hospital: hospital,
          selectedDepartmentId: hospital.departments.first.departmentId,
          selectedDate: DateTime.now(),
        ),
      );
    } catch (e) {
      emit(BookingError(message: e.toString()));
    }
  }

  void selectDepartment(int id) {
    final current = state as BookingSuccessLoaded;
    emit(current.copyWith(selectedDepartmentId: id));
  }

  void selectDate(DateTime date) {
    final current = state as BookingSuccessLoaded;
    emit(current.copyWith(selectedDate: date));
  }

  Future<List<AvailableTimeModel>> getDoctorAvailableTimes(
    int doctorId,
    DateTime date,
  ) async {
    return await _bookingData.getDoctorAvailableTimes(
      doctorId: doctorId,
      date: date,
    );
  }

  Future<void> bookAppointment({
    required int doctorId,
    required DateTime date,
    required String time,
  }) async {
    emit(BookingCreating());
    try {
      final formattedDate =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      final bookingId = await _bookingData.createBooking(
        doctorId: doctorId,
        date: formattedDate,
        time: time,
      );
      emit(BookingCreated(bookingId: bookingId));
    } catch (e) {
      emit(BookingError(message: e.toString()));
    }
  }
}
