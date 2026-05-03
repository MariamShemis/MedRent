import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_rent/features/devices_add_owner/data/data_source/add_device_owner_service.dart';
import 'package:med_rent/features/devices_add_owner/data/model/add_device_owner_model.dart';
import 'package:meta/meta.dart';

part 'owner_add_devices_state.dart';

class OwnerAddDevicesCubit extends Cubit<OwnerAddDevicesState> {
  final AddDeviceOwnerService addDeviceOwnerService;
  OwnerAddDevicesCubit(this.addDeviceOwnerService)
    : super(OwnerAddDevicesInitial());

  String? pickedImagePath;
  Future<void> pickImageOwner({required ImageSource sources}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: sources,
    );

    if (image != null) {
      pickedImagePath = image.path;
      emit(OwnerAddDeviceImagePicked(image.path));
    }
  }

  Future<void> addDeviceOwner({
    required String name,
    required String description,
    required double price,
    required String token,
  }) async {
    if (pickedImagePath == null) {
      emit(OwnerAddDevicesFailure("Please select a device image first"));
      return;
    }
    emit(OwnerAddDevicesLoading());

    final deviceOwnerModel = AddDeviceOwnerModel(
      name: name,
      description: description,
      pricePerDay: price,
      imagePath: pickedImagePath!,
    );

    try {
      final response = await addDeviceOwnerService.addDeviceOwner(
        deviceOwnerDData: deviceOwnerModel,
        token: token,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        pickedImagePath = null;
        emit(OwnerAddDevicesSuccess("Device Owner Added Successfully"));
      } else {
        emit(
          OwnerAddDevicesFailure(
            "Failed to add device owner. Please try again.",
          ),
        );
      }
    } on DioException catch (e) {
      print("Dio Error Type: ${e.type}");
      print("Dio Error Response: ${e.response?.data}");
      print("Dio Error Message: ${e.message}");

      String errorMessage = "Something went wrong";

      if (e.response?.data is Map) {
        errorMessage =
            e.response?.data['message'] ??
            e.response?.data['errors']?.toString() ??
            "Error";
      } else if (e.response?.data is String && e.response?.data.isNotEmpty) {
        errorMessage = e.response?.data;
      }

      emit(OwnerAddDevicesFailure(errorMessage));
    } catch (e) {
      print("General Error: $e");
      emit(OwnerAddDevicesFailure(e.toString()));
    }
  }
}
