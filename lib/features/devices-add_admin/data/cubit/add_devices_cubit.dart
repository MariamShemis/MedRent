import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_rent/features/devices-add_admin/data/data_source/add_devices_data.dart';
import 'package:med_rent/features/devices-add_admin/data/model/add_devices_model.dart';
import 'package:meta/meta.dart';

part 'add_devices_state.dart';

class AddDevicesCubit extends Cubit<AddDevicesState> {
  final AddDevicesData addDeviceService;
  AddDevicesCubit(this.addDeviceService) : super(AddDevicesInitial());
  String? pickedImagePath;

  Future<void> pickImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: source,
    ); // نستخدم الـ source اللي جاي من الـ UI

    if (image != null) {
      pickedImagePath = image.path;
      emit(AddDeviceImagePicked(image.path));
    }
  }

  Future<void> addDevice({
    required String name,
    required String description,
    required double price,
    required String token,
    required String ownerName,
    required String ownerEmail,
    required String ownerPassword,
    required String ownerPhone, // التوكن الخاص بالأدمن
  }) async {
    if (pickedImagePath == null) {
      emit(AddDevicesFailure("Please select a device image first"));
      return;
    }
    emit(AddDevicesLoading());

    final deviceModel = AddDeviceModel(
      name: name,
      description: description,
      pricePerDay: price,
      imagePath: pickedImagePath!,
      ownerName: ownerName, // تم التغيير من ثابت لديناميكي
      ownerEmail: ownerEmail,
      ownerPassword: ownerPassword,
      ownerPhone: ownerPhone,
    );

    try {
      final response = await addDeviceService.addDevice(
        deviceData: deviceModel,
        token: token,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(
          AddDevicesSuccess(
            response.data["message"] ?? "Device added successfully",
          ),
        );
      } else {
        emit(AddDevicesFailure("Something went wrong, please try again."));
      }
   }on DioException catch (e) {
  // السطرين دول هم اللي هيعرفونا المشكلة فين بالظبط
  print("Dio Error Type: ${e.type}");
  print("Dio Error Response: ${e.response?.data}");
  print("Dio Error Message: ${e.message}");

  String errorMessage = "Something went wrong";
  
  if (e.response?.data is Map) {
    errorMessage = e.response?.data['message'] ?? e.response?.data['errors']?.toString() ?? "Error";
  } else if (e.response?.data is String && e.response?.data.isNotEmpty) {
    errorMessage = e.response?.data;
  }
  
  emit(AddDevicesFailure(errorMessage));
} catch (e) {
  print("General Error: $e");
  emit(AddDevicesFailure(e.toString()));
}


  }

}