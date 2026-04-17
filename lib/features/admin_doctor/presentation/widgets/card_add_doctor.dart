import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class CardAddDoctor extends StatelessWidget {
  const CardAddDoctor({super.key, required this.onTap, required this.text});

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(1, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(20.r),
        color: ColorManager.lightGreen,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: ColorManager.white,
                fontSize: 15.sp,
              ),
            ),
            SizedBox(width: 5.h),
            Icon(Icons.add, color: ColorManager.white, size: 22.sp),
          ],
        ),
      ),
    );
  }
}
