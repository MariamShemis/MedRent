import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/admin_doctor/data/models/admin_doctor_model.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class AdminDoctorCard extends StatelessWidget {
  final AdminDoctorModel model;

  const AdminDoctorCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Container(
      padding: REdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorManager.lightBlue,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(1, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: ColorManager.white,
            child: Icon(
              Icons.person,
              size: 25.sp,
              color: ColorManager.secondary,
            ),
          ),
          SizedBox(height: 11.h),
          Text(
            model.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(
              context,
            ).textTheme.titleSmall!.copyWith(fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          RichText(
            text: TextSpan(
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontSize: 10.sp),
              children: <TextSpan>[
                TextSpan(text: "${model.experienceYears} ${appLocalizations.years_experience} - "),
                TextSpan(
                  text: model.specialization,
                  style: TextStyle(color: ColorManager.black),
                ),
              ],
            ),
          ),
          SizedBox(height: 11.w),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.access_time_outlined, size: 20.sp, color: ColorManager.greyText),
              SizedBox(width: 4.w),
              Text(
                appLocalizations.available,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(fontSize: 13.sp),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: BoxBorder.all(color: ColorManager.greyText , width: 1.5),
              ),
              child: Text(
                "${model.startTime} : ${model.endTime}",
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(fontSize: 12.sp),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          const Divider(
            thickness: 1,
            color: ColorManager.greyText,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(height: 8.h),
          Text(
            "${appLocalizations.consultationPrice}: ${model.consultationPrice}",
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(fontSize: 10.sp),
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.star1, color: Colors.amber, size: 23.sp),
                SizedBox(width: 5.w,),
                Text(
                  model.rating.toString(),
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
