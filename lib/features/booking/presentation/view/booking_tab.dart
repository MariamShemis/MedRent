import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/booking/presentation/widgets/bookind_calendar.dart';
import 'package:med_rent/features/booking/presentation/widgets/dapartment_selector.dart';
import 'package:med_rent/features/booking/presentation/widgets/doctor_card.dart';
import 'package:med_rent/features/booking/presentation/widgets/specialties_drop_down.dart';

class BookingTab extends StatelessWidget {
  const BookingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: ColorManager.darkBlue,
          ),
        ),
        title: Text(
          "Booking",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: ColorManager.darkBlue),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: REdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Schedule Your booking",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: const Color(0xFF0A1D47),
                  ),
                ),
                SizedBox(height: 16.h),
        
                const BookingCalendar(),
        
                SizedBox(height: 16.h),
        
                Text(
                  "Departments",
                  style: TextStyle(fontSize: 18.sp, color: ColorManager.darkBlue),
                ),
        
                SizedBox(height: 16.h),
                DapartmentSelector(),
                SizedBox(height: 16.h), 
                

                Text(
                  "Available Doctor",
                  style: TextStyle(fontSize: 18.sp, color: ColorManager.black ,),
                ),
SizedBox(height: 16.h),
SpecialtiesDropdown(),
SizedBox(height: 16.h),
DoctorCard(
  name: "Dr. Mohamed Ali",
  experience: "15 years",
  availableTimes: ["10:00 Am", "11:30 Am", "12:00 Pm"],
  imageUrl: "https://via.placeholder.com/150", // استبدليها بصور حقيقية
),
 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
