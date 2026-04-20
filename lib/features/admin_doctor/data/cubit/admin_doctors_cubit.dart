import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/features/admin_doctor/data/data_sources/admin_doctors_data_source.dart';
import 'admin_doctors_state.dart';

class AdminDoctorsCubit extends Cubit<AdminDoctorsState> {
  final AdminDoctorsDataSource _dataSource;

  AdminDoctorsCubit(this._dataSource) : super(AdminDoctorsInitial());

  void getDoctors() async {
    emit(AdminDoctorsLoading());
    try {
      final doctors = await _dataSource.getAdminDoctors();
      emit(AdminDoctorsSuccess(doctors));
    } catch (e) {
      emit(AdminDoctorsError("Failed to fetch doctors data: ${e.toString()}"));
    }
  }

  void searchDoctors({String? name, String? spec}) async {
    emit(AdminDoctorsLoading());
    try {
      final results = await _dataSource.searchDoctors(name: name, specialization: spec);
      emit(AdminDoctorsSuccess(results));
    } catch (e) {
      emit(AdminDoctorsError("Search failed: ${e.toString()}"));
    }
  }
}