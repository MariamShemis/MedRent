import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class ReservationCard extends StatelessWidget {
  final String patientName;
  final String status;
  final String phone;
  final String date;
  final String time;
  final VoidCallback onDisplayTap;

  const ReservationCard({
    super.key,
    required this.patientName,
    required this.status,
    required this.phone,
    required this.date,
    required this.time,
    required this.onDisplayTap,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Container(
      padding: REdgeInsets.all(20),
      margin: REdgeInsets.all(2),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                patientName,
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(fontSize: 16.sp),
              ),
              InkWell(
                onTap: onDisplayTap,
                child: Row(
                  children: [
                    Text(
                      appLocalizations.display,
                      style: Theme.of(context).textTheme.headlineLarge!
                          .copyWith(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 16.sp,
                      color: ColorManager.darkBlue,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                status,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 12.sp),
              ),
              Text(
                phone,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Text(
                date,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(fontSize: 14.sp),
              ),
              SizedBox(width: 50.w),
              Text(
                time,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(fontSize: 14.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
