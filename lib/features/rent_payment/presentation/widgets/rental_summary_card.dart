import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/l10n/app_localizations.dart';
import '../model/rental_model.dart';

class RentalSummaryCard extends StatelessWidget {
  final RentalModel model;

  const RentalSummaryCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
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
          Text(
            appLocalizations.rentalPeriod,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0Xff020A19),
            ),
          ),
          SizedBox(height: 8.h),
          _buildDetailRow("${appLocalizations.startDate}:", model.startDate),
          _buildDetailRow("${appLocalizations.endDate}:", model.endDate),
          const Divider(),
          _buildDetailRow(
            "${appLocalizations.rentalFee}:",
            "\$${model.rentalFee.toStringAsFixed(2)}",
          ),
          _buildDetailRow(
            "${appLocalizations.insuranceFee}:",
            "\$${model.insuranceFee.toStringAsFixed(2)}",
          ),
          _buildDetailRow(
            "${appLocalizations.taxes_Fee}:",
            "\$${model.taxesAndFees.toStringAsFixed(2)}",
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appLocalizations.totalCost,
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
