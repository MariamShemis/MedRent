import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/dashboard_doctor/data/cubit/dashboard_doctor_state.dart';
import 'package:med_rent/features/dashboard_doctor/data/data_sources/dashboard_doctor_data_source.dart';

class DoctorDashboardCubit extends Cubit<DoctorDashboardState> {
  final DoctorDashboardRemoteDataSource dataSource;

  DoctorDashboardCubit(this.dataSource) : super(DashboardInitial());

  Future<void> getDashboard() async {
    emit(DashboardLoading());

    try {
      final token = await SessionService.getAuthToken();

      if (token == null || token.isEmpty) {
        emit(DashboardError("No token found"));
        return;
      }

      final data = await dataSource.getDashboard(token);

      emit(DashboardLoaded(data));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}