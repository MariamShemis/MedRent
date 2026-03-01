import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class CustomCardAiChat extends StatelessWidget {
  const CustomCardAiChat({
    super.key,
    required this.color,
    required this.title,
    required this.isWidget,
    this.widget,
    this.subTitles = const [],
  });

  final Color color;
  final String title;
  final bool isWidget;
  final Widget? widget;
  final List<String> subTitles;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: REdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: REdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: ColorManager.darkBlue,
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  child: Icon(
                    Icons.add_box_outlined,
                    color: ColorManager.white,
                    size: 25,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
           isWidget
                ? (widget ?? const SizedBox())
                : Column(
                    children: subTitles.map((text) => Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start, // الأيقونة تكون فوق جنب أول سطر
                        children: [
                          Icon(Icons.check_circle, color: Colors.green, size: 20.sp),
                          SizedBox(width: 10.w),
                          Expanded( // مهم جداً عشان النصوص الطويلة تنزل سطر جديد
                            child: Text(
                              text,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}