import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/booking/data/cubit/booking_cubit.dart';
import 'package:med_rent/features/booking/presentation/widgets/bookind_calendar.dart';

import 'package:med_rent/features/booking/presentation/widgets/dapartment_selector.dart';
import 'package:med_rent/features/booking/presentation/widgets/doctor_card.dart';
import 'package:med_rent/features/booking/presentation/widgets/specialties_drop_down.dart';

class BookingTab extends StatelessWidget {
  const BookingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingCubit()..loadHospitalDetails(),
      child: Scaffold(
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
        body: BlocConsumer<BookingCubit, BookingState>(
          listener: (context, state) {
            if (state is BookingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is AppointmentBookingSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is BookingLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HospitalDetailsLoaded) {
              return SafeArea(
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

                        BookingCalendar(
  selectedDate: state.selectedDate,
  onDateSelected: (date) {
    context.read<BookingCubit>().selectDate(date);
  },
),
                        SizedBox(height: 16.h),

                        Text(
                          "Departments",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: ColorManager.darkBlue,
                          ),
                        ),

                        SizedBox(height: 16.h),
                        
                        // Department Selector مع البيانات الحقيقية
                        DapartmentSelector(
                          departments: state.hospital.departments,
                          selectedDepartmentId: state.selectedDepartmentId,
                          onDepartmentSelected: (deptId) {
                            context.read<BookingCubit>().selectDepartment(deptId);
                          },
                        ),
                        
                        SizedBox(height: 16.h),

                        Text(
                          "Available Doctor",
                          style: TextStyle(fontSize: 18.sp, color: ColorManager.black),
                        ),
                        
                        SizedBox(height: 16.h),
                        
                        // Specialties Dropdown مع البيانات الحقيقية
                        SpecialtiesDropdown(
                          departments: state.hospital.departments,
                          selectedDepartmentId: state.selectedDepartmentId,
                          onSpecialtySelected: (deptId) {
                            context.read<BookingCubit>().selectDepartment(deptId);
                          },
                        ),
                        
                        SizedBox(height: 16.h),

                        // عرض الدكاترة حسب القسم المختار
                        ..._buildDoctorsList(state, context),
                      ],
                    ),
                  ),
                ),
              );
            }

            if (state is BookingInitial) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Failed to load data'),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        context.read<BookingCubit>().loadHospitalDetails();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  List<Widget> _buildDoctorsList(HospitalDetailsLoaded state, BuildContext context) {
    try {
      final selectedDepartment = state.hospital.departments.firstWhere(
        (dept) => dept.departmentId == state.selectedDepartmentId,
      );

      if (selectedDepartment.doctors.isEmpty) {
        return [
          Center(
            child: Padding(
              padding: EdgeInsets.all(20.h),
              child: Text(
                'No doctors available',
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
            ),
          ),
        ];
      }

      return selectedDepartment.doctors.map((doctor) {
        final isSelected = state.selectedDoctor?.doctorId == doctor.doctorId;
        return DoctorCard(
          doctor: doctor,
          isSelected: isSelected,
          availableTimes: isSelected ? state.availableTimes : [],
          isLoadingTimes: isSelected && state.isLoadingTimes,
          onTap: () {
            context.read<BookingCubit>().selectDoctor(doctor);
          },
          onBookAppointment: (time) {
            context.read<BookingCubit>().bookAppointment(
              doctorId: doctor.doctorId,
              date: state.selectedDate,
              time: time,
            );
          },
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }
}