import '../models/admin_dashboard_model.dart';

abstract class AdminDashboardState {}

class AdminDashboardInitial extends AdminDashboardState {}

class AdminDashboardLoading extends AdminDashboardState {}

class AdminDashboardSuccess extends AdminDashboardState {
  final AdminDashboardModel model;
  AdminDashboardSuccess(this.model);
}

class AdminDashboardError extends AdminDashboardState {
  final String message;
  AdminDashboardError(this.message);
}