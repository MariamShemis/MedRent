import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewUserItem extends StatelessWidget {
  const ReviewUserItem({super.key, required this.userTitle, required this.description, required this.starRating});
  final String userTitle;
  final String description;
  final List<Widget> starRating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(child: Icon(Icons.person),),
            SizedBox(width: 10.w,),
            Text(
              userTitle,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14.sp),
            ),
            Spacer(),
            Row(
              children: starRating
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall
        ),
      ],
    );
  }
}
