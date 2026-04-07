import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/features/dashboard_doctor/data/cubit/dashboard_doctor_state.dart';
import 'package:med_rent/features/dashboard_doctor/presentation/widgets/appointment_pie_chart.dart';
import 'package:med_rent/features/dashboard_doctor/presentation/widgets/dashboard_state_card.dart';
import 'package:med_rent/features/dashboard_doctor/presentation/widgets/monthly_patients_chart.dart';
import 'package:med_rent/features/dashboard_doctor/presentation/widgets/weekly_reservations_chart.dart';
import 'package:med_rent/l10n/app_localizations.dart';

import '../../data/cubit/dashboard_doctor_cubit.dart' show DoctorDashboardCubit;

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorDashboardCubit>().getDashboard();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(appLocalizations.dashboard),
      ),
      body: BlocBuilder<DoctorDashboardCubit, DoctorDashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DashboardError) {
            return Center(child: Text(state.message));
          }

          if (state is DashboardLoaded) {
            final data = state.model;

            return SingleChildScrollView(
              padding: REdgeInsets.all(14),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DashboardStatCard(
                          value: data.totalPatients.toString(),
                          title: appLocalizations.totalPatients,
                          icon: Icons.group_outlined,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: DashboardStatCard(
                          value: data.todayBookings.toString(),
                          title: appLocalizations.todaysBookings,
                          icon: Iconsax.calendar_1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: DashboardStatCard(
                          value: data.waitingCount.toString(),
                          title: appLocalizations.pendingPatients,
                          icon: Iconsax.timer_14,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: DashboardStatCard(
                          value: data.rating.toString(),
                          title: appLocalizations.satisfactionRate,
                          icon: Iconsax.chart_1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  WeeklyReservationsChart(
                    data: data.weeklyBookings,
                    color: const Color(0xFFB2E2E2),
                  ),
                  SizedBox(height: 20.h),
                  AppointmentPieChart(
                    data: data.bookingTypes,
                  ),
                  SizedBox(height: 20.h),
                  MonthlyPatientsChart(
                    data: data.monthlyPatients,
                    color: const Color(0xFF6080DB),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}