import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/features/dashboard_doctor/data/models/dashboard_model.dart';
import 'package:med_rent/features/dashboard_doctor/presentation/widgets/dashboard_state_card.dart';
import 'package:med_rent/features/dashboard_doctor/presentation/widgets/monthly_patients_chart.dart';
import 'package:med_rent/features/dashboard_doctor/presentation/widgets/weekly_reservations_chart.dart';
import 'package:med_rent/features/dashboard_equipment_owner/data/cubit/equipment_owner_dashboard_cubit.dart';
import 'package:med_rent/features/dashboard_equipment_owner/data/cubit/equipment_owner_dashboard_state.dart';
import 'package:med_rent/features/dashboard_equipment_owner/presentation/widgets/appointment_pie_chart_e_owner.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class DashboardEquipmentOwner extends StatelessWidget {
  const DashboardEquipmentOwner({super.key});

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
      body: BlocBuilder<EquipmentOwnerDashboardCubit, EquipmentOwnerDashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DashboardError) {
            return Center(child: Text(state.message));
          } else if (state is DashboardLoaded) {
            final data = state.dashboard;
            return SingleChildScrollView(
              padding: REdgeInsets.all(14),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DashboardStatCard(
                          value: data.totalDevices.toString(),
                          title: appLocalizations.totalDevices,
                          icon: Icons.monitor_outlined,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: DashboardStatCard(
                          value: data.todayRentals.toString(),
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
                          value: data.pendingRentals.toString(),
                          title: appLocalizations.pendingPatients,
                          icon: Iconsax.timer_14,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: DashboardStatCard(
                          value: "${data.rating}%",
                          title: appLocalizations.satisfactionRate,
                          icon: Iconsax.chart_1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  WeeklyReservationsChart(
                    color: const Color(0xFF6FCB2D).withOpacity(0.4),
                    data: data.weeklyRentals
                        .map((e) => WeeklyBooking(day: e.day, count: e.count))
                        .toList(),
                  ),
                  SizedBox(height: 20.h),
                  AppointmentPieChartEOwner(rentalTypes: data.rentalTypes),
                  SizedBox(height: 20.h),
                  MonthlyPatientsChart(
                    color: const Color(0xFFDB60CD),
                    data: data.weeklyRentals
                        .map((e) => MonthlyPatient(month: 0, count: e.count))
                        .toList(),
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