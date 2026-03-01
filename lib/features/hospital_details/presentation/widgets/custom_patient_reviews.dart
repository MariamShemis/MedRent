import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/hospital_details/data/models/hospital_review_model.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class CustomPatientReviews extends StatelessWidget {
  final List<HospitalReviewModel> reviews;

  const CustomPatientReviews({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.patientReviews,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(height: 16.h),
        ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return Card(
              margin: EdgeInsets.zero,
              color: ColorManager.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 3,
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          review.userName,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const Spacer(),
                        Row(
                          children: List.generate(
                            5,
                                (i) => Icon(
                              Iconsax.star1,
                              color: i < review.rating ? ColorManager.yellow : ColorManager.greyText,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "\"${review.comment}\"",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 18.sp),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

