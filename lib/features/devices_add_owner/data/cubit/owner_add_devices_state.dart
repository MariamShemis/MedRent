part of 'owner_add_devices_cubit.dart';

@immutable
sealed class OwnerAddDevicesState {}

final class OwnerAddDevicesInitial extends OwnerAddDevicesState {}

final class OwnerAddDevicesLoading extends OwnerAddDevicesState {}

final class OwnerAddDevicesSuccess extends OwnerAddDevicesState {
  final String message;
  OwnerAddDevicesSuccess(this.message);
}

final class OwnerAddDevicesFailure extends OwnerAddDevicesState {
  final String message;
  OwnerAddDevicesFailure(this.message);
}

final class OwnerAddDeviceImagePicked extends OwnerAddDevicesState {
  final String imagePath;
  OwnerAddDeviceImagePicked(this.imagePath);
}