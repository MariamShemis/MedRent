import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/features/dashboard_admin/data/data_sources/admin_dashboard_data_source.dart';
import 'admin_dashboard_state.dart';

class AdminDashboardCubit extends Cubit<AdminDashboardState> {
  final AdminDashboardDataSource _dataSource;

  AdminDashboardCubit(this._dataSource) : super(AdminDashboardInitial());

  Future<void> fetchDashboardData() async {
    emit(AdminDashboardLoading());
    try {
      final data = await _dataSource.getDashboardData();
      emit(AdminDashboardSuccess(data));
    } catch (e) {
      emit(AdminDashboardError("Failed to load dashboard: ${e.toString()}"));
    }
  }
}