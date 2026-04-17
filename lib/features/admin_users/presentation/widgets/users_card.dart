import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/admin_users/data/models/user_model.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class UsersCard extends StatelessWidget {
  const UsersCard({super.key, required this.user, required this.textStatus});
  final UserModel user;
  final String textStatus;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Container(
      padding: REdgeInsets.all(20),
      margin: REdgeInsets.all(3),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                user.name,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontSize: 16.sp),
              ),
              Text(
                user.status,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 14.sp,
                  color: ColorManager.darkBlue,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            "${user.email} → ${user.role}",
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(fontSize: 12.sp),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${user.totalBookings} ${appLocalizations.reservation}",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
              ),
              Container(
                padding: REdgeInsets.symmetric(horizontal: 12 , vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFF5A78C),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(textStatus , style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: ColorManager.white,
                  fontSize: 13.sp,
                ),),
              )
            ],
          ),
        ],
      ),
    );
  }
}
