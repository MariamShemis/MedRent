import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class CustomCardHospital extends StatelessWidget {
  const CustomCardHospital({
    super.key,
    required this.image,
    required this.titleLocation,
    required this.subTitleLocation,
    required this.description,
    required this.rating,
    required this.onPressedElevatedButton,
    required this.onPressedOutlinedButton,
  });

  final String image;
  final String titleLocation;
  final String subTitleLocation;
  final String description;
  final double rating;
  final VoidCallback onPressedElevatedButton;
  final VoidCallback onPressedOutlinedButton;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Image.network(
            image,
            width: double.infinity,
            height: 200.h,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleLocation,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8.h),
                Text(
                  subTitleLocation,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      spacing: 5.w,
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        Text(
                          rating.toInt().toString(),
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onPressedElevatedButton,
                        child: Text(appLocalizations.bookNow),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onPressedOutlinedButton,
                        child: Text(appLocalizations.viewDetails),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
