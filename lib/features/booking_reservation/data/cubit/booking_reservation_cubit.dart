import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/features/booking_reservation/data/data_sources/owner_reservation_data_source.dart';
import 'package:med_rent/features/booking_reservation/data/models/reservation_details_model.dart';
import '../data_sources/admin_reservation_data_source.dart';
import '../data_sources/doctor_reservation_data_source.dart';
import '../models/reservation_model.dart';
import 'booking_reservation_state.dart';

class BookingReservationCubit extends Cubit<BookingReservationState> {
  final AdminReservationDataSource adminDS;
  final DoctorReservationDataSource doctorDS;
  final OwnerReservationDataSource ownerDS;

  List<ReservationModel> currentBookings = [];

  String currentSearch = '';
  String? currentStatus;

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
    if (search != null) currentSearch = search;
    currentStatus = status;

    emit(BookingReservationLoading());
    try {
      List<ReservationModel> results;

      if (role == 'Admin') {
        results = await adminDS.searchOperations(
          status: currentStatus ?? '',
          search: currentSearch,
        );
      } else if (role == 'Doctor') {
        results = await doctorDS.searchDoctorBookings(
          status: currentStatus ?? '',
          search: currentSearch,
        );
      } else {
        results = await ownerDS.getOwnerBookings(
          status: currentStatus ?? '',
          search: currentSearch,
        );
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