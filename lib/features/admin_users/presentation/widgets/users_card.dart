import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/admin_users/data/models/user_model.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class UsersCard extends StatelessWidget {
  const UsersCard({
    super.key,
    required this.user,
    required this.onBlockTap,
  });

  final UserModel user;
  final VoidCallback onBlockTap;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    bool isBlocked = user.status.toLowerCase() == 'blocked';
    Color statusColor = isBlocked ? Colors.red : const Color(0xFFF5A78C);
    Color statusTextColor = isBlocked ? ColorManager.white : const Color(0xFFF7865E);
    String buttonText = isBlocked ? "Unblock" : "Block";

    return Container(
      padding: REdgeInsets.all(20),
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
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                user.status,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 13.sp,
                  color: isBlocked ? Color(0xFFFA6531): ColorManager.darkBlue,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            "${user.email} → ${user.role}",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 13.sp,
              color: ColorManager.greyText,
            ),
          ),
          SizedBox(height: 12.h),
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
              InkWell(
                onTap: onBlockTap,
                child: Container(
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    buttonText,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: statusTextColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}