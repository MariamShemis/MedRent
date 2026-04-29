import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/features/admin_add_doctor/data/data_sources/admin_add_doctor_data_source.dart';
import 'package:med_rent/features/admin_add_doctor/data/models/add_doctor_department_model.dart';
import 'package:med_rent/features/admin_add_doctor/data/models/add_doctor_hospital_model.dart';
import 'package:med_rent/features/admin_add_doctor/data/models/add_doctor_model.dart';
import 'add_doctor_state.dart';

class AddDoctorCubit extends Cubit<AddDoctorState> {
  final AdminAddDoctorDataSource _dataSource;

  List<AddDoctorHospitalModel> hospitals = [];
  List<AddDoctorDepartmentModel> departments = [];

  AddDoctorCubit(this._dataSource) : super(AddDoctorInitial());

  Future<void> getHospitals() async {
    emit(AddDoctorLoading());
    try {
      hospitals = await _dataSource.getHospitals();
      emit(HospitalsLoaded(hospitals));
    } catch (e) {
      emit(AddDoctorError(e.toString()));
    }
  }

  Future<void> getDepartments(int hospitalId) async {
    emit(AddDoctorLoading());
    try {
      departments = await _dataSource.getDepartments(hospitalId);
      emit(DepartmentsLoaded(departments));
    } catch (e) {
      emit(AddDoctorError("Failed to load departments"));
    }
  }

  Future<void> addDoctor(AddDoctorModel doctor) async {
    emit(AddDoctorLoading());
    try {
      final msg = await _dataSource.addDoctor(doctor);
      emit(AddDoctorSuccess(msg));
    } catch (e) {
      emit(AddDoctorError("Error adding doctor"));
    }
  }
}