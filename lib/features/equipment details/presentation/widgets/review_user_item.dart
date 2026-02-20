import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/features/equipment%20details/data/models/equipment_review.dart';

class ReviewUserItem extends StatelessWidget {
  const ReviewUserItem({super.key, required this.review});
  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.blue.shade100,
              child: Icon(
                Icons.person,
                color: Colors.blue.shade800,
                size: 16.sp,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                review.userName ?? "Anonymous",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14.sp),
              ),
            ),
            Row(
              children: List.generate(5, (index) => Icon(
                Iconsax.star1,
                size: 16.sp,
                color: index < review.rating.floor()
                    ? Colors.amber
                    : Colors.grey.shade400,
              )),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          review.comment,
            style: Theme.of(context).textTheme.bodySmall
        ),
        SizedBox(height: 4.h),
      ],
    );
  }
}