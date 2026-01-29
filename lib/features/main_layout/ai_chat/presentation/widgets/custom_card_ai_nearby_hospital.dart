import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class CustomCardAiNearbyHospital extends StatelessWidget {
  const CustomCardAiNearbyHospital({
    super.key,
    required this.title,
    required this.subTitle,
    required this.rating,
    required this.textElevatedButton,
    required this.onPressed,
  });

  final String title;
  final String textElevatedButton;
  final String subTitle;
  final double rating;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.lightBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16.r),
      ),
      child: Padding(
        padding: REdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Text(
                  subTitle,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  rating.toString(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 5),
                Icon(Icons.star, color: Colors.yellow),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(textElevatedButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
