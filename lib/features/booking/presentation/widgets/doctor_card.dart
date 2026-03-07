import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/booking/data/cubit/booking_cubit.dart';
import 'package:med_rent/features/booking/data/model/booking_model.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class DoctorCard extends StatefulWidget {
  final DoctorModel doctor;
  final DateTime selectedDate;
  final Function(String time) onBookAppointment;

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.selectedDate,
    required this.onBookAppointment,
  });

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  List<AvailableTimeModel> availableTimes = [];
  bool isLoadingTimes = false;
  String? selectedTime;

  @override
  void initState() {
    super.initState();
    _loadTimes();
  }

  Future<void> _loadTimes() async {
    setState(() => isLoadingTimes = true);
    try {
      final cubit = context.read<BookingCubit>();
      final times = await cubit.getDoctorAvailableTimes(
        widget.doctor.doctorId,
        widget.selectedDate,
      );
      setState(() {
        availableTimes = times;
        isLoadingTimes = false;
      });
    } catch (_) {
      setState(() => isLoadingTimes = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: Colors.grey.withOpacity(0.1)),
      ),
      color: ColorManager.white,
      elevation: 5,
      child: Padding(
        padding: REdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35.r,
                  backgroundColor: ColorManager.lightBlue,
                  child:
                      widget.doctor.image != null &&
                          widget.doctor.image!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(40.r),
                          child: Image.network(
                            widget.doctor.image!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Text(
                          widget.doctor.name.isNotEmpty
                              ? widget.doctor.name[0]
                              : "D",
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: ColorManager.darkBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                SizedBox(width: 22.w,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.doctor.name,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 7.h),
                    Text(
                      "${widget.doctor.experienceYears} ${appLocalizations.years_experience}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 13.h),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 22.sp,
                  color: ColorManager.greyText,
                ),
                SizedBox(width: 8.w),
                Text(
                  appLocalizations.availableToday,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(fontSize: 18.sp),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            if (isLoadingTimes)
              const Center(child: CircularProgressIndicator())
            else if (availableTimes.isNotEmpty)
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: availableTimes.map((time) {
                  final isSelected = selectedTime == time.time;
                  return GestureDetector(
                    onTap: () => setState(() => selectedTime = time.time),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ColorManager.darkBlue
                            : const Color(0XFFF8FAFC),
                        borderRadius: BorderRadius.circular(8.r),
                        border: BoxBorder.all(color: isSelected ? ColorManager.darkBlue : ColorManager.lightGrey , width: 1)
                      ),
                      child: Text(
                        _formatTime(time.time),
                        style: Theme.of(context).textTheme.labelMedium!
                            .copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : ColorManager.black,
                            ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedTime != null
                    ? () {
                  widget.onBookAppointment(selectedTime!);
                }
                    : null,
                child: Text(appLocalizations.bookAppointment),
              )
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(String time) {
    try {
      final parts = time.split(':');
      final hour = int.parse(parts[0]);
      final minute = parts[1];
      final period = hour >= 12 ? 'PM' : 'AM';
      final hour12 = hour > 12 ? hour - 12 : hour;
      return '$hour12:$minute $period';
    } catch (_) {
      return time;
    }
  }
}
