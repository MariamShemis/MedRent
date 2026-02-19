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
    return InkWell(
      onTap: onPressedIconArrow,
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 10.h), 
        child: Row(
          children: [
            Container(
              padding: REdgeInsets.all(6),
              decoration: BoxDecoration(
                color: ColorManager.lightBlue,
                shape: BoxShape.circle,
              ),
              child: Icon(iconPrefix, size: 22.sp, color: ColorManager.darkBlue),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 20.sp, 
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1, 
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(iconSuffixArrow, size: 16.sp, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}