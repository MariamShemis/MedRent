import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/booking_reservation_doctor/data/models/reservation_details_model.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class ReservationDetailsDialog extends StatelessWidget {
  final ReservationDetailsModel details;

  const ReservationDetailsDialog({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Container(
          width: 400.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: ColorManager.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(context),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildInfoRow(
                      context,
                      Iconsax.calendar_1,
                      appLocalizations.duration,
                      "${appLocalizations.from}: ${details.startDate.split('T')[0]}",
                      isEndDate: true,
                      endValue: "To: ${details.endDate.split('T')[0]}",
                    ),
                    if (details.time.isNotEmpty)
                      _buildInfoRow(
                        context,
                        Iconsax.clock,
                        appLocalizations.time,
                        details.time,
                      ),
                    if (details.deviceName != null &&
                        details.deviceName!.isNotEmpty)
                      _buildInfoRow(
                        context,
                        Iconsax.monitor_mobbile,
                        appLocalizations.device,
                        details.deviceName!,
                      ),
                    if (details.price != null)
                      _buildInfoRow(
                        context,
                        Iconsax.money_send,
                        appLocalizations.totalPrice,
                        "${details.price} \$",
                      ),
                    if (details.status.isNotEmpty)
                      _buildInfoRow(
                        context,
                        Iconsax.info_circle,
                        appLocalizations.status,
                        details.status,
                      ),
                    if (details.notes != null && details.notes!.isNotEmpty)
                      _buildInfoRow(
                        context,
                        Iconsax.note_2,
                        appLocalizations.notes,
                        details.notes!,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            appLocalizations.close,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 36.r,
            backgroundColor: ColorManager.secondary2,
            child: Text(
              details.name.isNotEmpty ? details.name[0].toUpperCase() : "?",
              style: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 28.sp),
            ),
          ),
          SizedBox(height: 13.h),
          Text(details.name, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: 5.h),
          Text(
            details.phone,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    bool isEndDate = false,
    String? endValue,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: ColorManager.secondary2,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 22.sp, color: ColorManager.black),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.black,
                  ),
                ),
                if (isEndDate && endValue != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    endValue,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.black,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
