import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class ContainerLanguageHomeTab extends StatelessWidget {
  const ContainerLanguageHomeTab({super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 5 , vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: ColorManager.darkBlue,
            width: 1.5,
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
