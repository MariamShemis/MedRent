import 'package:bloc/bloc.dart';
import 'package:med_rent/features/devices_admin/data/data_sources/devices_data.dart';
import 'package:med_rent/features/devices_admin/data/models/devices_model.dart';
import 'package:meta/meta.dart';

part 'devices_admin_state.dart';

class DevicesAdminCubit extends Cubit<DevicesAdminState> {
  final DevicesData adminData;
  DevicesAdminCubit(this.adminData) : super(DevicesAdminInitial());
  void fetchAdminDevices(String token) async {
    emit(DevicesAdminLoading());
    try {
      final response = await adminData.getAllEquipments(token);
final data = response.data is List ? response.data as List : [];      final equipments = data.map((e) => DevicesModel.fromJson(e)).toList();
      emit(DevicesAdminSuccess(equipments));
    } catch (e) {
      emit(DevicesAdminError("Failed to load devices: ${e.toString()}"));
    }
  }
  void searchAdminDevices(String token, String query) async {
    if (query.isEmpty) {
      fetchAdminDevices(token);
      return;
    }
    emit(DevicesAdminLoading());
    try {
      final response = await adminData.searchEquipments(token, query);
      
     final dynamic responseData = response.data;
      final List<dynamic> dataList = responseData is List ? responseData : [responseData];
      
      final equipments = dataList.map((e) => DevicesModel.fromJson(e)).toList();
      emit(DevicesAdminSuccess(equipments));
    } catch (e) {
      emit(DevicesAdminError("Search failed: ${e.toString()}"));
    }
  }
}

