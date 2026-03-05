import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String experience;
  final List<String> availableTimes;
  final String imageUrl;

  const DoctorCard({
    super.key,
    required this.name,
    required this.experience,
    required this.availableTimes,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage: NetworkImage(
                  imageUrl,
                ), 
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.black,
                    ),
                  ),
                  Text(
                    "$experience experience",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: ColorManager.greyText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),

          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 18.sp,
                color: ColorManager.greyText,
              ),
              SizedBox(width: 8.w),
              Text(
                "Available Today",
                style: TextStyle(fontSize: 13.sp, color: ColorManager.greyText),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // قائمة المواعيد (الصفوف)
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: availableTimes
                .map(
                  (time) => Container(
                    padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0XffF8FAFC),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Color(0XffF8FAFC)),
                    ),
                    child: Text(
                      time,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: ColorManager.black,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 16.h),

          // زرار Book Appointment
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.darkBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: Text(
                "Book Appointment",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ColorManager.background),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
