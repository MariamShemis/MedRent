import 'package:bloc/bloc.dart';
import 'package:med_rent/features/dashboard_equipment_owner/data/cubit/equipment_owner_dashboard_state.dart';
import 'package:med_rent/features/dashboard_equipment_owner/data/data_sources/equipment_owner_dashboard_data.dart';

class EquipmentOwnerDashboardCubit extends Cubit<EquipmentOwnerDashboardState> {
  final EquipmentOwnerDashboardData service;

  EquipmentOwnerDashboardCubit(this.service) : super(DashboardLoading());

  void loadDashboard() async {
    emit(DashboardLoading());
    try {
      final dashboard = await service.fetchDashboard();
      emit(DashboardLoaded(dashboard));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}