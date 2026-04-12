import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class ReservationCard extends StatelessWidget {
  final String patientName;
  final String status;
  final String itemName;
  final String phone;
  final int? amount;
  final String date;
  final String time;
  final String? bookingStatus;
  final VoidCallback onDisplayTap;
  final bool isAdmin;

  const ReservationCard({
    super.key,
    required this.patientName,
    required this.status,
    required this.phone,
    required this.date,
    required this.time,
    required this.onDisplayTap,
    this.isAdmin = false,
    this.bookingStatus,
    this.amount,
    required this.itemName,
  });

  Color _getStatusColor(String? status) {
    if (status == null) return ColorManager.darkBlue;

    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'completed':
        return Colors.green;
      case 'pending':
      case 'pendingpayment':
        return Color(0xFFE08261);
      case 'canceled':
        return Colors.red;
      case 'pickuprequested':
        return Colors.blue;
      default:
        return ColorManager.darkBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    Widget actionWidget;
    if (isAdmin) {
      actionWidget = Text(
        bookingStatus ?? "",
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
          fontSize: 13.sp,
          color: _getStatusColor(bookingStatus),
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      actionWidget = InkWell(
        onTap: onDisplayTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              appLocalizations.display,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              size: 16.sp,
              color: ColorManager.darkBlue,
            ),
          ],
        ),
      );
    }

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  patientName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge!.copyWith(fontSize: 16.sp),
                ),
              ),
              actionWidget,
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  status.isNotEmpty && itemName.isNotEmpty
                      ? "$status → $itemName"
                      : "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 12.sp),
                ),
              ),
              Text(
                phone,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (isAdmin)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$amount \$",
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontSize: 13.sp),
                ),
                SizedBox(width: 10.w),
                Text(
                  date,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontSize: 13.sp),
                ),
                SizedBox(width: 10.w),
                Text(
                  time,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontSize: 13.sp),
                ),
              ],
            )
          else
            Row(
              children: [
                Text(
                  date,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontSize: 14.sp),
                ),
                SizedBox(width: 50.w),
                Text(
                  time,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
