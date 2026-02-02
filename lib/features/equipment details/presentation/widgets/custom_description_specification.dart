import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class CustomDescriptionSpecification extends StatelessWidget {
  const CustomDescriptionSpecification({super.key, required this.text1,});
  final String text1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.circle,size: 7.sp,
              color: ColorManager.greyText,
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                text1,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
