import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class CustomContainerTips extends StatelessWidget {
  const CustomContainerTips({
    super.key,
    required this.iconImage,
    required this.title,
    required this.subtitle,
    this.isColorBlue = true,
  });
  final String iconImage;
  final String title;
  final String subtitle;
  final bool isColorBlue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.symmetric(vertical: 5.h),
      padding: REdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: isColorBlue ? ColorManager.darkBlue : ColorManager.secondary2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(iconImage , height: 25.h, width: 25.w,),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: isColorBlue ? ColorManager.white : ColorManager.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            subtitle,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isColorBlue ? ColorManager.white : ColorManager.greyText,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
