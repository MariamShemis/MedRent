import 'package:med_rent/features/notification_setting/data/models/notification_settings_model.dart';

abstract class NotificationSettingsState {}

class NotificationSettingsInitial extends NotificationSettingsState {}

class NotificationSettingsLoading extends NotificationSettingsState {}

class NotificationSettingsSuccess extends NotificationSettingsState {
  final NotificationSettingsModel settings;

  NotificationSettingsSuccess(this.settings);
}

class NotificationSettingsError extends NotificationSettingsState {
  final String message;

  NotificationSettingsError(this.message);
}

class NotificationSettingsUpdateLoading extends NotificationSettingsState {}

class NotificationSettingsUpdateSuccess extends NotificationSettingsState {}
