import 'package:med_rent/features/admin_doctor/data/models/admin_doctor_model.dart';

abstract class AdminDoctorsState {}

class AdminDoctorsInitial extends AdminDoctorsState {}
class AdminDoctorsLoading extends AdminDoctorsState {}
class AdminDoctorsSuccess extends AdminDoctorsState {
  final List<AdminDoctorModel> doctors;
  AdminDoctorsSuccess(this.doctors);
}
class AdminDoctorsError extends AdminDoctorsState {
  final String message;
  AdminDoctorsError(this.message);
}