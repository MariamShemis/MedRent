import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/rental_model.dart'; // تأكدي من مسار الملف

class RentalSummaryCard extends StatelessWidget {
  final RentalModel model; // بنبعت الموديل كامل هنا

  const RentalSummaryCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F7FA),
        borderRadius: BorderRadius.circular(15.r),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  model.equipmentName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  model.equipmentDescription,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
                SizedBox(height: 10.h),
                Image.network(
                  model.equipmentImage,
                  height: 120.h,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.broken_image,
                      size: 50.h,
                      color: Colors.grey,
                    ); 
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          const Divider(),
          
          const Text(
            "Rental Period",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0Xff020A19),
            ),
          ),
          SizedBox(height: 8.h),

          _buildDetailRow("Start Date:", model.startDate),
          _buildDetailRow("End Date:", model.endDate),

          const Divider(),

          _buildDetailRow(
            "Rental Fee:",
            "\$${model.rentalFee.toStringAsFixed(2)}",
          ),
          _buildDetailRow(
            "Insurance Fee:",
            "\$${model.insuranceFee.toStringAsFixed(2)}",
          ),
          _buildDetailRow(
            "Taxes & Fees:",
            "\$${model.taxesAndFees.toStringAsFixed(2)}",
          ),

          const Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Cost",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0Xff020A19),
                ),
              ),
              Text(
                "\$${model.totalCost.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0Xff676767),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 13.sp, color: Color(0Xff676767)),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
