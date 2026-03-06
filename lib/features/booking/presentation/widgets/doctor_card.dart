import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/booking/data/model/booking_model.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  final bool isSelected;
  final List<AvailableTimeModel> availableTimes;
  final bool isLoadingTimes;
  final VoidCallback onTap;
  final Function(String) onBookAppointment;

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.isSelected,
    required this.availableTimes,
    required this.isLoadingTimes,
    required this.onTap,
    required this.onBookAppointment,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                  backgroundColor: ColorManager.lightBlue,
                  child: Text(
                    doctor.name.isNotEmpty ? doctor.name[0] : 'D',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: ColorManager.darkBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.black,
                      ),
                    ),
                    Text(
                      "${doctor.experienceYears} years experience",
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

            if (isLoadingTimes)
              const Center(child: CircularProgressIndicator())
            else if (availableTimes.isEmpty)
              const SizedBox.shrink()
            else
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: availableTimes
                    .map(
                      (time) => GestureDetector(
                        onTap: () => onBookAppointment(time.time),
                        child: Container(
                          padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0XffF8FAFC),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: const Color(0XffF8FAFC)),
                          ),
                          child: Text(
                            _formatTime(time.time),
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: ColorManager.black,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            
            SizedBox(height: 16.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: availableTimes.isNotEmpty
                    ? () => onBookAppointment(availableTimes.first.time)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.darkBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: Text(
                  "Book Appointment",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ColorManager.background
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(String time) {
    try {
      final parts = time.split(':');
      if (parts.length == 2) {
        final hour = int.parse(parts[0]);
        final minute = parts[1];
        final period = hour >= 12 ? 'PM' : 'AM';
        final hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
        return '$hour12:$minute $period';
      }
    } catch (e) {
      return time;
    }
    return time;
  }
}