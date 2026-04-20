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
    bool hasTime =
        model.startTime.isNotEmpty &&
        model.endTime.isNotEmpty &&
        model.startTime != "00:00:00";

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35.r,
            backgroundColor: ColorManager.white,
            backgroundImage: model.imageURL.isNotEmpty
                ? NetworkImage(model.imageURL)
                : null,
            child: model.imageURL.isEmpty
                ? Icon(Icons.person, size: 30.sp, color: ColorManager.secondary)
                : null,
          ),
          SizedBox(height: 8.h),
          Text(
            model.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            "${model.experienceYears} ${appLocalizations.years_experience}",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontSize: 10.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            model.specialization,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 10.sp,
              color: ColorManager.secondary,
            ),
          ),
          SizedBox(height: 10.h),
          if (hasTime) ...[
            Row(
              children: [
                Icon(
                  Icons.access_time_outlined,
                  size: 18.sp,
                  color: ColorManager.greyText,
                ),
                SizedBox(width: 4.w),
                Text(
                  appLocalizations.available,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(fontSize: 12.sp),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: ColorManager.greyText.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Text(
                  "${model.startTime} : ${model.endTime}",
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(fontSize: 11.sp),
                ),
              ),
            ),
          ] else ...[
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 18.sp,
                  color: ColorManager.secondary,
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    model.hospital,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 11.sp,
                      color: ColorManager.darkBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
          ],
          hasTime ? const Spacer() : SizedBox(height: 2.h),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Iconsax.star1, color: Colors.amber, size: 18.sp),
              SizedBox(width: 4.w),
              Text(
                model.rating.toString(),
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(fontSize: 12.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
