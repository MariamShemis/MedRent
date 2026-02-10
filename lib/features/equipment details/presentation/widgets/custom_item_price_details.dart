import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class CustomItemPriceDetails extends StatelessWidget {
  const CustomItemPriceDetails({
    super.key,
    required this.isColorDark,
    required this.textPer,
    required this.textPrice,
    this.textSavePrice,
  });

  final bool isColorDark;
  final String textPer;
  final String textPrice;
  final String? textSavePrice;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: REdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: isColorDark
                ? ColorManager.darkBlue
                : ColorManager.lightBlue.withValues(alpha: 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textPer,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: isColorDark
                      ? ColorManager.background
                      : ColorManager.darkBlue,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                textPrice,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isColorDark
                      ? ColorManager.background
                      : ColorManager.darkBlue,
                ),
              ),
            ],
          ),
        ),

        if (textSavePrice != null && isColorDark)
          PositionedDirectional(
            top: -20.h,
            end: 13.w,
            child: Container(
              padding: REdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorManager.lightBlue,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: ColorManager.black),
              ),
              child: Text(
                textSavePrice!,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

