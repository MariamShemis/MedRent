import 'package:med_rent/features/admin_add_doctor/data/models/add_doctor_department_model.dart';
import 'package:med_rent/features/admin_add_doctor/data/models/add_doctor_hospital_model.dart';

abstract class AddDoctorState {}

class AddDoctorInitial extends AddDoctorState {}

class AddDoctorLoading extends AddDoctorState {}

class HospitalsLoaded extends AddDoctorState {
  final List<AddDoctorHospitalModel> hospitals;
  HospitalsLoaded(this.hospitals);
}

class DepartmentsLoaded extends AddDoctorState {
  final List<AddDoctorDepartmentModel> departments;
  DepartmentsLoaded(this.departments);
}

class AddDoctorSuccess extends AddDoctorState {
  final String message;
  AddDoctorSuccess(this.message);
}

class AddDoctorError extends AddDoctorState {
  final String error;
  AddDoctorError(this.error);
}