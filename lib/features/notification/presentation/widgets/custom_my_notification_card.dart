import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class CustomMyNotificationCard extends StatelessWidget {
  const CustomMyNotificationCard({super.key, required this.isRead, required this.onTap});
  final bool isRead;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.zero,
      color: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16.r),
      ),
      child: Padding(
        padding: REdgeInsets.all(8.0),
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => InkWell(
            //onTap: onTap,
            child: Container(
              padding: REdgeInsets.symmetric(horizontal: 5, vertical: 10),
              //margin: REdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: isRead ? ColorManager.lightBlue : Colors.transparent,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Iconsax.calendar_1,
                        size: 30.sp,
                        color: ColorManager.black,
                      ),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: Text(
                          "Doctor Consultation Confirmed",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headlineLarge!
                              .copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      ?isRead
                          ? CircleAvatar(
                              backgroundColor: ColorManager.secondary,
                              radius: 7.r,
                            )
                          : null,
                      SizedBox(width: 4.w),
                      Text(
                        "2h",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Your appointment with Dr. Smith is scheduled for 2:00 PM today.",
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => Padding(
            padding: REdgeInsets.symmetric(vertical: 12.0),
            child: Divider(
              thickness: 2,
              color: ColorManager.lightGrey,
              endIndent: 10.w,
              indent: 10.w,
            ),
          ),
          itemCount: 2,
        ),
      ),
    );
  }
}
