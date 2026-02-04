import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class ContainerProfileItem extends StatelessWidget {
  const ContainerProfileItem({
    super.key,
    required this.iconPrefix,
    required this.iconSuffixArrow,
    required this.text,
    required this.onPressedIconArrow,
  });

  final IconData iconPrefix;
  final IconData iconSuffixArrow;
  final String text;
  final VoidCallback onPressedIconArrow;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: REdgeInsets.all(6),
          decoration: BoxDecoration(
            color: ColorManager.lightBlue,
            shape: BoxShape.circle,
          ),
          child: Icon(iconPrefix, size: 25.sp),
        ),
        SizedBox(width: 10.w),
        Text(
          text,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        IconButton(onPressed: onPressedIconArrow, icon: Icon(iconSuffixArrow)),
      ],
    );
  }
}
