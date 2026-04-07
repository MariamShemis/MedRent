import 'package:med_rent/features/dashboard_equipment_owner/data/models/equipment_owner_dashboard_model.dart';

abstract class EquipmentOwnerDashboardState {}

class DashboardLoading extends EquipmentOwnerDashboardState {}

class DashboardLoaded extends EquipmentOwnerDashboardState {
  final EquipmentOwnerDashboardModel dashboard;

  DashboardLoaded(this.dashboard);
}

class DashboardError extends EquipmentOwnerDashboardState {
  final String message;

  DashboardError(this.message);
}

