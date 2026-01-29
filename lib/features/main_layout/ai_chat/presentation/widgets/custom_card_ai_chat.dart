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
    this.subTitle1 = "",
    this.subTitle2 = "",
    this.subTitle3 = "",
  });

  final Color color;
  final String title;
  final bool isWidget;
  final Widget? widget;
  final String subTitle1;
  final String subTitle2;
  final String subTitle3;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: REdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
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
            ?isWidget
                ? widget
                : Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 10.w),
                          Text(
                            subTitle1,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 10.w),
                          Text(
                            subTitle2,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 10.w),
                          Text(
                            subTitle3,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
