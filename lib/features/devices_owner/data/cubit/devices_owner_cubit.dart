import 'package:bloc/bloc.dart';
import 'package:med_rent/features/devices_owner/data/data_source/owner_devices_service.dart';
import 'package:med_rent/features/devices_owner/data/model/owner_devices_model.dart';
import 'package:meta/meta.dart';

part 'devices_owner_state.dart';

class DevicesOwnerCubit extends Cubit<DevicesOwnerState> {
  final OwnerDevicesService ownerDevicesService;
  DevicesOwnerCubit( this.ownerDevicesService) : super(DevicesOwnerInitial());

  // داخل الـ Cubit
void fetchOwnerDevices(String token) async {
  emit(DevicesOwnerLoading());
  try {
    final response = await ownerDevicesService.getAllEquipments(token);
    
    // تأكدي أن الـ response ناجح (Dio عادة يرمي Exception لو فيه خطأ، لكن الاحتياط واجب)
    if (response.statusCode == 200) {
      final List data = response.data; // Dio بيحول الـ JSON لـ List تلقائياً
      final devices = data.map((e) => OwnerDevicesModel.fromJson(e)).toList();
      emit(DevicesOwnerSuccess(devices));
    } else {
      emit(DevicesOwnerError("Server Error: ${response.statusCode}"));
    }
  } catch (e) {
    emit(DevicesOwnerError("Failed to load devices: ${e.toString()}"));
  }
}
}
