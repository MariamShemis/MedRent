import 'package:med_rent/features/main_layout/hospital/data/models/hospital_model.dart';

abstract class HospitalState {}

class HospitalInitial extends HospitalState {}

class HospitalLoading extends HospitalState {}

class HospitalLoaded extends HospitalState {
  final List<HospitalModel> hospitals;

  HospitalLoaded(this.hospitals);
}

class HospitalError extends HospitalState {
  final String message;

  HospitalError(this.message);
}

