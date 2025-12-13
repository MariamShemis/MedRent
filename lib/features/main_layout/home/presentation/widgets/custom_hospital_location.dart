import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class CustomHospitalLocation extends StatelessWidget {
  const CustomHospitalLocation({
    super.key,
    required this.bgImage,
    required this.title,
    required this.subTitle,
    required this.textButton,
    required this.icon,
    required this.onPressedButton,
  });

  final String bgImage;
  final String title;
  final String subTitle;
  final String textButton;
  final IconData icon;
  final VoidCallback onPressedButton;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(bgImage, width: double.infinity, fit: BoxFit.fill),
        Container(
          height: 80.h,
          padding: REdgeInsets.symmetric(vertical: 5.0, horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.r)),
            gradient: LinearGradient(
              colors: [
                ColorManager.darkBlue.withValues(alpha: 0.8),
                ColorManager.secondary
                    .withValues(alpha: 0.8)
                    .withValues(alpha: 0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon),
              SizedBox(width: 6.w),
              Expanded(
                child: Column(
                  spacing: 4.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorManager.white,
                      ),
                    ),
                    Text(
                      subTitle,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: ColorManager.white,
                        fontSize: 12.sp,
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
        ),
      ],
    );
  }
}
