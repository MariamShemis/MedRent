import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/features/booking/data/cubit/booking_cubit.dart';
import 'package:med_rent/features/booking/presentation/widgets/bookind_calendar.dart';
import 'package:med_rent/features/booking/presentation/widgets/dapartment_selector.dart';
import 'package:med_rent/features/booking/presentation/widgets/doctor_card.dart';
import 'package:med_rent/features/booking/presentation/widgets/specialties_drop_down.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class BookingTab extends StatelessWidget {
  const BookingTab({super.key, required this.selectedHospitalId});

  final int selectedHospitalId;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => BookingCubit(ApiClient())..loadHospitalDetails(selectedHospitalId),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(appLocalizations.booking),
        ),
        body: BlocConsumer<BookingCubit, BookingState>(
          listener: (context, state) {
            if (state is BookingSuccessLoaded) {
            } else if (state is BookingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is BookingLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is BookingSuccessLoaded) {
              final selectedDepartment = state.hospital.departments.firstWhere(
                (d) => d.departmentId == state.selectedDepartmentId,
              );
              return SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations.scheduleYour_booking,
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
                      appLocalizations.departments,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: ColorManager.darkBlue,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    DapartmentSelector(
                      departments: state.hospital.departments,
                      selectedDepartmentId: state.selectedDepartmentId,
                      onDepartmentSelected: (id) {
                        context.read<BookingCubit>().selectDepartment(id);
                      },
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      appLocalizations.availableDoctors,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: ColorManager.black,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SpecialtiesDropdown(
                      departments: state.hospital.departments,
                      selectedDepartmentId: state.selectedDepartmentId,
                      onSpecialtySelected: (id) {
                        context.read<BookingCubit>().selectDepartment(id);
                      },
                    ),
                    SizedBox(height: 16.h),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: selectedDepartment.doctors.length,
                      itemBuilder: (context, index) {
                        final doctor = selectedDepartment.doctors[index];
                        // return DoctorCard(
                        //   doctor: doctor,
                        //   selectedDate: state.selectedDate,
                        //   onBookAppointment: (time) {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //         content: Text(
                        //           "Appointment booked\nDoctor: ${doctor.name}\nTime: $time",
                        //         ),
                        //         backgroundColor: Colors.green,
                        //       ),
                        //     );
                        //     Navigator.pushNamed(
                        //       context,
                        //       AppRoutes.bookingPayment,
                        //       arguments: {
                        //         "doctorName": doctor.name,
                        //         "time": time,
                        //         "date": state.selectedDate
                        //       },
                        //     );
                        //   },
                        // );
                        return DoctorCard(
                          doctor: doctor,
                          selectedDate: state.selectedDate,
                          onBookAppointment: (time) {
                            final date = state.selectedDate;
                            final formattedDate =
                                "${date.day}/${date.month}/${date.year}";
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  "${appLocalizations.appointment_booked}:\t\t\t${appLocalizations.doctor}: ${doctor.name}\n${appLocalizations.date}: $formattedDate\t\t\t\t${appLocalizations.time}: $time",
                                ),
                              ),
                            );
                            Navigator.pushNamed(
                              context,
                              AppRoutes.bookingPayment,
                              arguments: {
                                "doctorName": doctor.name,
                                "date": date,
                                "time": time,
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
