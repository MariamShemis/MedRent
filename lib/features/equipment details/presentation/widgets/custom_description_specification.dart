import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class CustomDescriptionSpecification extends StatelessWidget {
  const CustomDescriptionSpecification({super.key, required this.text1, required this.text2, required this.text3, required this.text4});
  final String text1;
  final String text2;
  final String text3;
  final String text4;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.circle,size: 7.sp,
              color: ColorManager.greyText,
            ),
            SizedBox(width: 14.w),
            Text(
              text1,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
            ),
          ],
        ),
        SizedBox(height: 4.h,),
        Row(
          children: [
            Icon(
              Icons.circle,size: 7.sp,
              color: ColorManager.greyText,
            ),
            SizedBox(width: 14.w),
            Text(
              text2,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
            ),
          ],
        ),
        SizedBox(height: 4.h,),
        Row(
          children: [
            Icon(
              Icons.circle,size: 7.sp,
              color: ColorManager.greyText,
            ),
            SizedBox(width: 14.w),
            Text(
              text3,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
            ),
          ],
        ),
        SizedBox(height: 4.h,),
        Row(
          children: [
            Icon(
              Icons.circle,size: 7.sp,
              color: ColorManager.greyText,
            ),
            SizedBox(width: 14.w),
            Text(
              text4,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
            ),
          ],
        ),
      ],
    );
  }
}
