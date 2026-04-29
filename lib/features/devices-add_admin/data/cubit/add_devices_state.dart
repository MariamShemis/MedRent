part of 'add_devices_cubit.dart';

@immutable
sealed class AddDevicesState {}

final class AddDevicesInitial extends AddDevicesState {}
final class AddDevicesLoading extends AddDevicesState {}

final class AddDevicesSuccess extends AddDevicesState {
  final String message;
  AddDevicesSuccess(this.message);
}

final class AddDevicesFailure extends AddDevicesState {
  final String errMessage;
  AddDevicesFailure(this.errMessage);
}

final class AddDeviceImagePicked extends AddDevicesState {
  final String imagePath;
  AddDeviceImagePicked(this.imagePath);
}