import 'package:med_rent/features/dashboard_doctor/data/models/dashboard_model.dart';

abstract class DoctorDashboardState {}

class DashboardInitial extends DoctorDashboardState {}

class DashboardLoading extends DoctorDashboardState {}

class DashboardLoaded extends DoctorDashboardState {
  final DoctorDashboardModel model;

  DashboardLoaded(this.model);
}

class DashboardError extends DoctorDashboardState {
  final String message;

  DashboardError(this.message);
}