import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/devices_owner/data/model/owner_devices_model.dart';

class DevicesOwnerCard extends StatelessWidget {
  const DevicesOwnerCard({super.key, required this.device});
  final OwnerDevicesModel device;

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
      return Colors.blueAccent;
    } else {
      return const Color(0Xff30D9C9);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: ColorManager.white,
      elevation: 5,
     
      child: Padding(
        padding:  REdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          device.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: ColorManager.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 6),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0Xff7ADEF3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.monitor_outlined,
                          size: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: getStatusColor(device.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    device.status,
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              device.description,
              style: const TextStyle(
                color: ColorManager.greyText,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
        
            const SizedBox(height: 10),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: ColorManager.black,
                      fontSize: 13,
                    ),
                    children: [
                      const TextSpan(
                        text: "From ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      TextSpan(
                        text: "\$${device.pricePerDay}/day",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
        
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDF5FB),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${device.rating}",
                        style: const TextStyle(
                          color: Color(0XffFFC107),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
        
                      Icon(Icons.star, color: const Color(0XffFFC107), size: 14),
                    ],
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
