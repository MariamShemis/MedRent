import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/features/notification_setting/data/cubit/notification_settings_state.dart';
import 'package:med_rent/features/notification_setting/data/data_sources/notification_settings_data_source.dart';
import 'package:med_rent/features/notification_setting/data/models/notification_settings_model.dart';

class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  final NotificationSettingsDataSource _dataSource;
  NotificationSettingsCubit(this._dataSource) : super(NotificationSettingsInitial());
  NotificationSettingsModel? currentSettings;

  Future<void> fetchSettings() async {
    emit(NotificationSettingsLoading());
    try {
      currentSettings = await _dataSource.getSettings();
      if (isClosed) return;
      emit(NotificationSettingsSuccess(currentSettings!));
    } catch (e) {
      if (isClosed) return;
      print("❌ Notification Error: $e");
      emit(NotificationSettingsError("Settings failed to load: $e"));
    }
  }

  void toggleAppointment(bool value) {
    if (currentSettings != null) {
      currentSettings!.appointmentReminders = value;
      emit(NotificationSettingsSuccess(currentSettings!));
    }
  }

  void toggleRental(bool value) {
    if (currentSettings != null) {
      currentSettings!.equipmentRentalAlerts = value;
      emit(NotificationSettingsSuccess(currentSettings!));
    }
  }

  Future<void> saveSettings() async {
    emit(NotificationSettingsUpdateLoading());
    try {
      await _dataSource.updateSettings(currentSettings!);
      emit(NotificationSettingsUpdateSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(NotificationSettingsError("Failed to save changes"));
    }
  }
}