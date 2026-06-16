import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/l10n/app_localizations.dart';
import '../model/booking_model.dart';

class BookingSummaryCard extends StatelessWidget {
  final BookingModel model;

  const BookingSummaryCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.appointmentSummary,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            CircleAvatar(
              radius: 28.r,
              backgroundColor: const Color(0xFF031B4E),
              // TODO: when the backend returns the doctor avatar url, replace this with image.
              child: Text(
                model.doctorName.isNotEmpty ? model.doctorName[0] : 'D',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.doctorName,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF020A19),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    model.departmentName,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFF676767),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),
        const Divider(),
        // Hospital
        // _buildDetailRow("Hospital", model.hospitalName),
        _buildDetailRow(appLocalizations.date, model.date),
        _buildDetailRow(appLocalizations.time, model.time),
        // const Divider(),
        _buildDetailRow(
          appLocalizations.consultationFee,
          "${model.price.toStringAsFixed(2)} ${appLocalizations.lE}",
        ),
        SizedBox(height: 8.h),
        Divider(thickness: 1.h, color: Color(0xffc8c8c8)),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              appLocalizations.total,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: ColorManager.darkBlue,
              ),
            ),
            Text(
              "${model.price.toStringAsFixed(2)} ${appLocalizations.lE}",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: ColorManager.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.darkBlue,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: ColorManager.darkGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
