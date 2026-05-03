import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/devices_admin/data/models/devices_model.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class DeviceAdminCard extends StatelessWidget {
  final DevicesModel device;

  const DeviceAdminCard({super.key, required this.device});

  Color getStatusColor(String status) {
    final String statusLower = status.trim().toLowerCase();

    if (statusLower.contains('avaliable') ||
        statusLower.contains('available')) {
      return const Color(0Xff8BE2EA);
    } else if (statusLower.contains('active')) {
      return const Color(0Xff8BEA95);
    } else if (statusLower.contains('maintainace') ||
        statusLower.contains('maintenance')) {
      return const Color(0XffECB26A);
    } else if (statusLower.contains('booked')) {
      return Colors.blue;
    } else {
      return const Color(0Xff30D9C9);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Card(
      margin: REdgeInsets.only(bottom: 15, left: 2, top: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      color: ColorManager.white,
      elevation: 5,
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          device.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            color: ColorManager.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Container(
                        padding: REdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0XffBDEFF9),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Icon(
                          Icons.monitor_outlined,
                          size: 16.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: getStatusColor(device.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    device.status,
                    style: TextStyle(
                      color: getStatusColor(device.status),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              "${appLocalizations.owner}: ${device.ownerName} → ${device.totalRentals} ${appLocalizations.rentals}",
              style: TextStyle(color: ColorManager.greyText, fontSize: 12.sp),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${appLocalizations.from} \$${device.pricePerDay}/${appLocalizations.day}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: ColorManager.black,
                  ),
                ),
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9E6),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    "${appLocalizations.revenue}: ${device.totalRevenue}",
                    style: TextStyle(
                      color: Color(0XffFFC107),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
