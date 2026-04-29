part of 'devices_admin_cubit.dart';

@immutable
sealed class DevicesAdminState {}

final class DevicesAdminInitial extends DevicesAdminState {}
final class DevicesAdminLoading extends DevicesAdminState {}

final class DevicesAdminSuccess extends DevicesAdminState {
  final List<DevicesModel> equipments;
  DevicesAdminSuccess(this.equipments);
}

final class DevicesAdminError extends DevicesAdminState {
  final String errorMessage;
  DevicesAdminError(this.errorMessage);
}