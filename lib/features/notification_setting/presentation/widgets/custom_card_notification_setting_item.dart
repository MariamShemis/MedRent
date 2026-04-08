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
    this.onChangedBooking,
    this.onChangedRental,
    this.isBooking = false, this.isBookingAlert, this.onChangedAppointment,
  });

  final bool isAppointmentBooking;
  final bool isEquipmentRental;
  final bool isBooking;
  final bool? isBookingAlert;
  final void Function(bool)? onChangedBooking;
  final void Function(bool)? onChangedAppointment;
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
        padding: REdgeInsets.symmetric(horizontal: 10.0, vertical: 13),
        child: isBooking
            ? Column(
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
                          Iconsax.notification,
                          size: 28.sp,
                          color: ColorManager.black,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          appLocalizations.newBookingAlerts,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headlineLarge!
                              .copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 100,
                        child: CupertinoSwitch(
                          value: isBookingAlert ?? false,
                          activeColor: Color(0xFF00FF00),
                          trackColor: Colors.grey.shade300,
                          onChanged: onChangedBooking,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      SizedBox(width: 50.w),
                      Text(
                        appLocalizations
                            .notification_when_a_new_patient_books,
                        textAlign: TextAlign.start,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(fontSize: 13.sp),
                      ),
                    ],
                  ),
                ],
              )
            : Column(
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
                          size: 28.sp,
                          color: ColorManager.black,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          appLocalizations.appointmentReminders,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headlineLarge!
                              .copyWith(
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
                          onChanged: onChangedAppointment,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      SizedBox(width: 50.w),
                      Text(
                        appLocalizations.reminders_for_upcoming_visits,
                        textAlign: TextAlign.start,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(fontSize: 13.sp),
                      ),
                    ],
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
                          size: 28.sp,
                          color: ColorManager.black,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          appLocalizations.equipmentRentalAlerts,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headlineLarge!
                              .copyWith(
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
                          onChanged: onChangedRental,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      SizedBox(width: 50.w),
                      Text(
                        appLocalizations
                            .reminders_for_return_dates_and_rental_status,
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(fontSize: 13.sp),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
