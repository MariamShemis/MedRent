import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/equipment%20details/presentation/widgets/review_user_item.dart';

class UserReview extends StatelessWidget {
  const UserReview({
    super.key,
    required this.rating,
    required this.ratingReview,
    required this.listRatingStar,
    required this.ratingBar,
    required this.userTitle1,
    required this.userTitle2,
    required this.userDescription1,
    required this.userDescription2,
    required this.userStarRating1,
    required this.userStarRating2,
  });

  final String rating;
  final String ratingReview;
  final List<Widget> listRatingStar;
  final Widget ratingBar;
  final String userTitle1;
  final String userTitle2;
  final String userDescription1;
  final String userDescription2;
  final List<Widget> userStarRating1;
  final List<Widget> userStarRating2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorManager.lightBlue,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rating,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(children: listRatingStar),
                  SizedBox(height: 6.h),
                  Text(ratingReview,  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 10.sp , fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(width: 20.w),
              Expanded(child: ratingBar),
            ],
          ),
          SizedBox(height: 10.h),
          Divider(color: ColorManager.greyText,thickness: 1,),
          SizedBox(height: 8.h),
          ReviewUserItem(
            userTitle: userTitle1,
            description: userDescription1,
            starRating: userStarRating1,
          ),
          SizedBox(height: 16.h),
          ReviewUserItem(
            userTitle: userTitle2,
            description: userDescription2,
            starRating: userStarRating2,
          ),
        ],
      ),
    );
  }
}
