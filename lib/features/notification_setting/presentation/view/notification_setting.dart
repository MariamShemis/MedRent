import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/features/notification_setting/presentation/widgets/custom_card_notification_setting_item.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  bool isAppointmentBooking = false;
  bool isEquipmentRental = true;
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(appLocalizations.notificationSettings),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              appLocalizations
                  .choose_which_notifications_you_would_like_to_receive_You_can_update_these_settings_at_any_time,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontSize: 13.sp),
            ),
            SizedBox(height: 50.h),
            CustomCardNotificationSettingItem(
              isAppointmentBooking: isAppointmentBooking,
              isEquipmentRental: isEquipmentRental,
              onChangedBooking: (value) {
                setState(() {
                  isAppointmentBooking != isAppointmentBooking;
                });
              },
              onChangedRental: (value) {
                setState(() {
                  isEquipmentRental != isEquipmentRental;
                });
              },
            ),
            SizedBox(height: 50.h),
            ElevatedButton(
              onPressed: () {},
              child: Text(appLocalizations.saveChanges),
            ),
          ],
        ),
      ),
    );
  }
}
