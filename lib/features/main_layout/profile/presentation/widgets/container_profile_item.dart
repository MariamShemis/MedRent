import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class ContainerProfileItem extends StatelessWidget {
  const ContainerProfileItem({
    super.key,
    required this.iconPrefix,
    required this.iconSuffixArrow,
    required this.text,
    this.isLanguage = false,
    required this.onPressedIconArrow, this.textLanguage,
  });

  final IconData iconPrefix;
  final IconData iconSuffixArrow;
  final String text;
  final String? textLanguage;
  final bool isLanguage;
  final VoidCallback onPressedIconArrow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressedIconArrow,
      borderRadius: BorderRadius.circular(16.r),
      child: Row(
        children: [
          Container(
            padding: REdgeInsets.all(6),
            decoration: BoxDecoration(
              color: ColorManager.lightBlue,
              shape: BoxShape.circle,
            ),
            child: Icon(iconPrefix, size: 24.sp, color: ColorManager.black),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          isLanguage
              ? Row(
                  spacing: 3.sp,
                  children: [
                    Text(
                      textLanguage! ,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      iconSuffixArrow,
                      size: 18.sp,
                      color: ColorManager.darkBlue,
                    ),
                  ],
                )
              : Icon(
                  iconSuffixArrow,
                  size: 18.sp,
                  color: ColorManager.darkBlue,
                ),
        ],
      ),
    );
  }
}
