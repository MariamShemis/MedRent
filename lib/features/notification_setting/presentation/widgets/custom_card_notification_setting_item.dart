import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class CustomCardNotificationSettingItem extends StatelessWidget {
  const CustomCardNotificationSettingItem({
    super.key,
    required this.isAppointmentBooking,
    required this.isEquipmentRental,
    this.onChangedAppointment,
    this.onChangedRental,
  });

  final bool isAppointmentBooking;
  final bool isEquipmentRental;
  final void Function(bool)? onChangedAppointment;
  final void Function(bool)? onChangedRental;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Card(
      elevation: 5,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      color: ColorManager.white,
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 10.0, vertical: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Appointment
            Row(
              children: [
                _icon(Iconsax.calendar_1),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    appLocalizations.appointmentReminders,
                    style: Theme.of(context).textTheme.headlineLarge!
                        .copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                _switch(isAppointmentBooking, onChangedAppointment),
              ],
            ),

            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.only(left: 50.w),
              child: Text(
                appLocalizations.reminders_for_upcoming_visits,
                style: Theme.of(context).textTheme.bodyMedium!
                    .copyWith(fontSize: 13.sp),
              ),
            ),

            SizedBox(height: 20.h),

            /// Rental
            Row(
              children: [
                _icon(Iconsax.notification),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    appLocalizations.equipmentRentalAlerts,
                    style: Theme.of(context).textTheme.headlineLarge!
                        .copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                _switch(isEquipmentRental, onChangedRental),
              ],
            ),

            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.only(left: 50.w),
              child: Text(
                appLocalizations
                    .reminders_for_return_dates_and_rental_status,
                style: Theme.of(context).textTheme.bodyMedium!
                    .copyWith(fontSize: 13.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _icon(IconData icon) {
    return Container(
      padding: REdgeInsets.all(6),
      decoration: BoxDecoration(
        color: ColorManager.lightBlue,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 28.sp, color: ColorManager.black),
    );
  }

  Widget _switch(bool value, void Function(bool)? onChanged) {
    return SizedBox(
      height: 30,
      width: 70,
      child: CupertinoSwitch(
        value: value,
        activeColor: ColorManager.secondary,
        trackColor: Colors.grey.shade300,
        onChanged: onChanged,
      ),
    );
  }
}
