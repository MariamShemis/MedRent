import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/equipment%20details/presentation/view_model/equipment_review.dart';
import 'package:med_rent/features/equipment%20details/presentation/view_model/rating_summary.dart'; // ✅ إضافة
import 'package:med_rent/features/equipment%20details/presentation/widgets/review_user_item.dart';

class UserReview extends StatefulWidget {
  const UserReview({
    super.key,
    required this.rating,
    required this.ratingReview,
    required this.reviews,
    required this.ratingSummary,
  });

  final String rating;
  final String ratingReview;
  final List<ReviewModel> reviews;
  final RatingSummaryModel ratingSummary;

  @override
  State<UserReview> createState() => _UserReviewState();
}

class _UserReviewState extends State<UserReview> {
  @override
  Widget build(BuildContext context) {
    final Map<int, int> ratingDistribution = _getDistributionFromSummary();
    final int totalReviews = widget.reviews.isNotEmpty
        ? widget.reviews.length
        : widget.ratingSummary.count;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorManager.lightBlue,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.rating,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Iconsax.star1,
                        size: 20.sp,
                        color: index < double.parse(widget.rating).floor()
                            ? Colors.amber
                            : Colors.grey.shade400,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    widget.ratingReview,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: _buildRatingBars(ratingDistribution, totalReviews),
              ),
            ],
          ),

          SizedBox(height: 16.h),
          Divider(color: ColorManager.greyText, thickness: 1),

          if (widget.reviews.isNotEmpty) ...[
            SizedBox(height: 12.h),

            Container(
              constraints: BoxConstraints(maxHeight: 400.h),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.reviews.length,
                itemBuilder: (context, index) {
                  final review = widget.reviews[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: ReviewUserItem(review: review),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Map<int, int> _getDistributionFromSummary() {
    final Map<int, int> distribution = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    if (widget.ratingSummary.distribution != null &&
        widget.ratingSummary.distribution!.isNotEmpty) {
      for (var dist in widget.ratingSummary.distribution!) {
        if (dist.rating >= 1 && dist.rating <= 5) {
          distribution[dist.rating] = dist.count;
        }
      }
    } else if (widget.reviews.isNotEmpty) {
      return _calculateRatingDistribution(widget.reviews);
    }

    return distribution;
  }

  Map<int, int> _calculateRatingDistribution(List<ReviewModel> reviews) {
    final Map<int, int> distribution = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};

    for (var review in reviews) {
      final int rating = review.rating.floor();
      if (distribution.containsKey(rating)) {
        distribution[rating] = distribution[rating]! + 1;
      }
    }

    return distribution;
  }

  Widget _buildRatingBars(Map<int, int> distribution, int totalReviews) {
    return Column(
      children: [5, 4, 3, 2, 1].map((rating) {
        final count = distribution[rating] ?? 0;
        final percentage = totalReviews > 0
            ? (count / totalReviews).toDouble()
            : 0.0;

        return Padding(
          padding: EdgeInsets.only(bottom: 6.h),
          child: Row(
            children: [
              SizedBox(
                width: 20.w,
                child: Text(
                  '$rating',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontSize: 13.sp),
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: LinearProgressIndicator(
                  value: percentage,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation(ColorManager.darkBlue),
                  borderRadius: BorderRadius.circular(4.r),
                  minHeight: 10.h,
                ),
              ),
              SizedBox(width: 4.w),

              Text(
                '${(percentage * 100).toDouble().toInt().toStringAsFixed(1).trimLeft()}%',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(fontSize: 13.sp),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
