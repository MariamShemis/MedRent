import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class CustomContainerService extends StatelessWidget {
  const CustomContainerService({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.textButton,
    required this.onPressedButton,
  });

  final String title;
  final String subTitle;
  final IconData icon;
  final String textButton;
  final VoidCallback onPressedButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 10, vertical: 14),
      margin: REdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: ColorManager.lightBlue,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: ColorManager.secondary),
          SizedBox(width: 10.w,),
          Expanded(
            child: Column(
              spacing: 5.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: ColorManager.darkBlue),
                ),
                Text(
                  subTitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onPressedButton,
            style: ElevatedButton.styleFrom(padding: REdgeInsets.all(10)),
            child: Text(
              textButton,
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: ColorManager.white),
            ),
          ),
        ],
      ),
    );
  }
}
