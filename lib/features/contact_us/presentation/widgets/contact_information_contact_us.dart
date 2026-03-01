import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class ContactInformationContactUs extends StatelessWidget {
  const ContactInformationContactUs({super.key, required this.location, required this.phoneNumber, required this.email});
  final String location;
  final String phoneNumber;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: ColorManager.lightBlue,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: REdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: ColorManager.darkBlue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Iconsax.location5,
                  color: ColorManager.white,
                  size: 23.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  location,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(fontSize: 14.sp),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                padding: REdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: ColorManager.darkBlue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.phone_iphone_rounded,
                  color: ColorManager.white,
                  size: 23.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  phoneNumber,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(fontSize: 14.sp),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                padding: REdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: ColorManager.darkBlue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.email_outlined,
                  color: ColorManager.white,
                  size: 23.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  email,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(fontSize: 14.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
