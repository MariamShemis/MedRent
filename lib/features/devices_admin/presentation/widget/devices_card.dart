import 'package:flutter/material.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/devices_admin/data/models/devices_model.dart';

class DeviceCard extends StatelessWidget {
  final DevicesModel device;

  const DeviceCard({super.key , required this.device});

 Color getStatusColor(String status) {
  final String statusLower = status.trim().toLowerCase();

  if (statusLower.contains('avaliable') || statusLower.contains('available')) {
    return const Color(0Xff8BE2EA); 
  } else if (statusLower.contains('active')) {
    return const Color(0Xff8BEA95);
  } else if (statusLower.contains('maintainace') || statusLower.contains('maintenance')) {
    return const Color(0XffECB26A);  
  } else if (statusLower.contains('booked')) {
    return Colors.blue; 
  } else {
    return const Color(0Xff30D9C9); 
  }
}
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
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
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        device.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: ColorManager.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                     
                      padding: const EdgeInsets.symmetric(horizontal: 5 , vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0XffBDEFF9),
                  borderRadius: BorderRadius.circular(16),
                ),
                      child: const Icon(
                        
                        Icons.monitor_outlined,
                        size: 16,
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
                  color: getStatusColor(device.status).withOpacity(
                    0.1,
                  ), // الحماية هنا إن اللون لازم يتبعت
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  device.status,
                  style: TextStyle(
                    color: getStatusColor(device.status),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Text(
            "Owner: ${device.ownerName} → ${device.totalRentals} Rentals",
            style: const TextStyle( color :ColorManager.greyText, fontSize: 12),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                "From \$${device.pricePerDay}/day",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: ColorManager.black,
                  
                ),
              ),
              // Revenue Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9E6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "Revenues: ${device.totalRevenue}",
                  style: const TextStyle(
                    color: Color(0XffFFC107),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
