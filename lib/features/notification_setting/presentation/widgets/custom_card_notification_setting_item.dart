import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class CustomCardNotificationSettingItem extends StatelessWidget {
  const CustomCardNotificationSettingItem({super.key, required this.isAppointmentBooking, required this.isEquipmentRental, this.onChangedBooking, this.onChangedRental});
  final bool isAppointmentBooking;
  final bool isEquipmentRental;
  final void Function(bool)? onChangedBooking;
  final void Function(bool)? onChangedRental;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Card(
      elevation: 5,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16.r),
      ),
      color: ColorManager.white,
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 10.0 , vertical: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  padding: REdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: ColorManager.lightBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.calendar_1,
                    size: 24.sp,
                    color: ColorManager.black,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    appLocalizations.appointmentReminders,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 70,
                  child: CupertinoSwitch(
                    value: isAppointmentBooking,
                    activeColor: ColorManager.secondary,
                    trackColor: Colors.grey.shade300,
                    onChanged: onChangedBooking,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h,),
            Text(
              appLocalizations.reminders_for_upcoming_visits,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontSize: 13.sp),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Container(
                  padding: REdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: ColorManager.lightBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.notification,
                    size: 24.sp,
                    color: ColorManager.black,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    appLocalizations.equipmentRentalAlerts,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 70,
                  child: CupertinoSwitch(
                    value: isEquipmentRental,
                    activeColor: ColorManager.secondary,
                    trackColor: Colors.grey.shade300,
                    onChanged: onChangedRental
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h,),
            Text(
              appLocalizations.reminders_for_return_dates_and_rental_status,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontSize: 13.sp),
            ),
          ],
        ),
      ),
    );
  }
}
