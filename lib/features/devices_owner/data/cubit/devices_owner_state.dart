part of 'devices_owner_cubit.dart';

@immutable
sealed class DevicesOwnerState {}

final class DevicesOwnerInitial extends DevicesOwnerState {}

final class DevicesOwnerLoading extends DevicesOwnerState {}

final class DevicesOwnerSuccess extends DevicesOwnerState {
  final List<OwnerDevicesModel> devices;
  DevicesOwnerSuccess(this.devices);
}

final class DevicesOwnerError extends DevicesOwnerState {
  final String message;
  DevicesOwnerError(this.message);
}

