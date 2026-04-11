import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/features/booking_reservation_doctor/data/data_sources/owner_reservation_data_source.dart';
import 'package:med_rent/features/booking_reservation_doctor/data/models/reservation_details_model.dart';
import '../data_sources/admin_reservation_data_source.dart';
import '../data_sources/doctor_reservation_data_source.dart';
import '../models/reservation_model.dart';
import 'booking_reservation_state.dart';

class BookingReservationCubit extends Cubit<BookingReservationState> {
  final AdminReservationDataSource adminDS;
  final DoctorReservationDataSource doctorDS;
  final OwnerReservationDataSource ownerDS;

  List<ReservationModel> currentBookings = [];

  BookingReservationCubit({
    required this.adminDS,
    required this.doctorDS,
    required this.ownerDS,
  }) : super(BookingReservationInitial());

  Future<void> fetchBookings({
    required String role,
    String? search,
    String? status,
  }) async {
    emit(BookingReservationLoading());
    try {
      List<ReservationModel> results;

      if (search == null || search.isEmpty) {
        if (role == 'Admin') {
          results = await adminDS.getAllOperations();
        } else if (role == 'Doctor') {
          results = await doctorDS.getAllDoctorBookings();
        } else {
          results = await ownerDS.getOwnerBookings();
        }
      } else {
        if (role == 'Admin') {
          results = await adminDS.searchOperations(
            status: status ?? 'booked',
            search: search,
          );
        } else if (role == 'Doctor') {
          results = await doctorDS.searchDoctorBookings(
            status: status ?? 'pending',
            search: search,
          );
        } else {
          results = await ownerDS.getOwnerBookings(
            status: status ?? 'booked',
            search: search,
          );
        }
      }

      currentBookings = results;
      emit(BookingReservationSuccess(results));
    } catch (e) {
      emit(BookingReservationError(e.toString()));
    }
  }

  Future<void> getBookingDetails(int id, String role) async {
    try {
      ReservationDetailsModel details;
      if (role == 'Doctor') {
        details = await doctorDS.getDoctorBookingDetails(id);
      } else {
        details = await ownerDS.getOwnerBookingDetails(id);
      }
      emit(BookingDetailsLoaded(details));
    } catch (e) {
      emit(BookingReservationError(e.toString()));
    }
  }
}