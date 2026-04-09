import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class CustomMyNotificationCard extends StatelessWidget {
  const CustomMyNotificationCard({
    super.key,
    required this.isRead,
    required this.onTap,
    required this.title,
    required this.message,
    required this.createdAt,
    this.isBooking = false,
    required this.role,
  });

  final bool isRead;
  final bool isBooking;
  final String title;
  final String message;
  final DateTime createdAt;
  final VoidCallback onTap;
  final String role;

  String _formatTimeAgo(DateTime dateTime) {
    final duration = DateTime.now().difference(dateTime);

    if (duration.inDays >= 30) {
      return '${(duration.inDays / 30).floor()}mo';
    } else if (duration.inDays >= 1) {
      return '${duration.inDays}d';
    } else if (duration.inHours >= 1) {
      return '${duration.inHours}h';
    } else if (duration.inMinutes >= 1) {
      return '${duration.inMinutes}m';
    } else {
      return 'now';
    }
  }

  @override
  Widget build(BuildContext context) {
    final IconData leadingIcon = (role == 'Patient')
        ? (isBooking ? Iconsax.calendar_1 : Iconsax.box_1)
        : Iconsax.box_1;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: !isRead ? ColorManager.lightBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(leadingIcon, size: 28.sp, color: ColorManager.black),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (!isRead)
                  CircleAvatar(
                    backgroundColor: ColorManager.secondary,
                    radius: 5.r,
                  ),
                SizedBox(width: 8.w),
                // هنا بنعرض الوقت المختصر
                Text(
                  _formatTimeAgo(createdAt),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.darkBlue.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: REdgeInsetsDirectional.only(start: 38.w),
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme.bodyMedium!
                    .copyWith(fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}