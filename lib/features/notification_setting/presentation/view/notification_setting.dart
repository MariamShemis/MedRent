import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/features/notification_setting/data/cubit/notification_settings_cubit.dart';
import 'package:med_rent/features/notification_setting/data/cubit/notification_settings_state.dart';
import 'package:med_rent/features/notification_setting/presentation/widgets/custom_card_notification_setting_item.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class NotificationSetting extends StatelessWidget {
  const NotificationSetting({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final String role = ModalRoute.of(context)!.settings.arguments as String? ?? 'Patient';
    final bool isPatient = (role == 'Patient');
    final bool isSpecialRole = (role == 'Doctor' || role == 'EquipmentOwner');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(appLocalizations.notificationSettings),
      ),
      body: !isPatient
          ? _buildStaticContent(context, appLocalizations, isSpecialRole)
          : BlocConsumer<NotificationSettingsCubit, NotificationSettingsState>(
        listener: (context, state) {
          if (state is NotificationSettingsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
          if (state is NotificationSettingsUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Updated Successfully"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is NotificationSettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final cubit = context.read<NotificationSettingsCubit>();
          if (cubit.currentSettings == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return _buildMainContent(
            context: context,
            appLocalizations: appLocalizations,
            isSpecialRole: isSpecialRole,
            isPatient: true,
            cubit: cubit,
            state: state,
          );
        },
      ),
    );
  }
  Widget _buildMainContent({
    required BuildContext context,
    required AppLocalizations appLocalizations,
    required bool isSpecialRole,
    required bool isPatient,
    NotificationSettingsCubit? cubit,
    NotificationSettingsState? state,
  }) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            appLocalizations.choose_which_notifications_you_would_like_to_receive_You_can_update_these_settings_at_any_time,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13.sp),
          ),
          SizedBox(height: 50.h),
          CustomCardNotificationSettingItem(
            isBooking: isSpecialRole,
            isAppointmentBooking: cubit!.currentSettings!.appointmentReminders,
            isEquipmentRental: cubit.currentSettings!.equipmentRentalAlerts,
            isBookingAlert: cubit.currentSettings!.appointmentReminders,
            onChangedAppointment: (value) => cubit.toggleAppointment(value),
            onChangedRental: (value) => cubit.toggleRental(value),
            onChangedBooking: (value) => cubit.toggleAppointment(value),
          ),
          SizedBox(height: 50.h),
          ElevatedButton(
            onPressed: (state is NotificationSettingsUpdateLoading)
                ? null
                : () => cubit.saveSettings(),
            child: (state is NotificationSettingsUpdateLoading)
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : Text(appLocalizations.saveChanges),
          ),
        ],
      ),
    );
  }
  Widget _buildStaticContent(BuildContext context, AppLocalizations appLocalizations, bool isSpecialRole) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            appLocalizations.choose_which_notifications_you_would_like_to_receive_You_can_update_these_settings_at_any_time,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13.sp),
          ),
          SizedBox(height: 50.h),
          CustomCardNotificationSettingItem(
            isBooking: isSpecialRole,
            isAppointmentBooking: true,
            isEquipmentRental: true,
            isBookingAlert: true,
            onChangedAppointment: (v) {},
            onChangedRental: (v) {},
            onChangedBooking: (v) {},
          ),
          SizedBox(height: 50.h),
          ElevatedButton(
            onPressed: () {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(content: Text("Static Mode: No API for this role yet")),
              // );
            },
            child: Text(appLocalizations.saveChanges),
          ),
        ],
      ),
    );
  }
}