import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/features/dashboard_admin/data/cubit/admin_dashboard_cubit.dart';
import 'package:med_rent/features/dashboard_admin/data/cubit/admin_dashboard_state.dart';
import 'package:med_rent/features/dashboard_admin/presentation/widgets/appointment_pie_chart_admin.dart';
import 'package:med_rent/features/dashboard_admin/presentation/widgets/weekly_reservations_chart_admin.dart';
import 'package:med_rent/features/dashboard_doctor/presentation/widgets/dashboard_state_card.dart';
import 'package:med_rent/features/dashboard_doctor/presentation/widgets/monthly_patients_chart.dart';
import 'package:med_rent/l10n/app_localizations.dart';
import '../../../dashboard_doctor/data/models/dashboard_model.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  @override
  void initState() {
    super.initState();
    context.read<AdminDashboardCubit>().fetchDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(appLocalizations.dashboard),
      ),
      body: BlocBuilder<AdminDashboardCubit, AdminDashboardState>(
        builder: (context, state) {
          if (state is AdminDashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AdminDashboardError) {
            return Center(child: Text(state.message));
          } else if (state is AdminDashboardSuccess) {
            final data = state.model;

            return SingleChildScrollView(
              padding: REdgeInsets.all(14),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DashboardStatCard(
                            value: data.totalEquipments.toString(),
                            title: appLocalizations.totalDevices,
                            icon: Icons.monitor_outlined,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: DashboardStatCard(
                            value: data.totalBookings.toString(),
                            title: appLocalizations.totalBookings,
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
                            value: data.totalRental.toString(),
                            title: appLocalizations.totalRentals,
                            icon: Iconsax.calendar_edit,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: DashboardStatCard(
                            value: data.totalHospitals.toString(),
                            title: appLocalizations.totalHospitals,
                            icon: Iconsax.hospital,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: DashboardStatCard(
                            value: data.totalDoctors.toString(),
                            title: appLocalizations.totalDoctor,
                            icon: Icons.medical_services_outlined,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: DashboardStatCard(
                            value: data.totalUsers.toString(),
                            title: appLocalizations.totalUsers,
                            icon: Icons.group_outlined,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: DashboardStatCard(
                            value: "${data.totalRevenue}\$",
                            title: appLocalizations.revenue,
                            icon: Iconsax.money_send,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    WeeklyReservationsChartAdmin(
                      days: data.weeklyDays,
                      bookings: data.weeklyBookings,
                    ),
                    SizedBox(height: 20.h),
                    AppointmentPieChartAdmin(
                      names: data.bookingTypesNames,
                      counts: data.bookingTypesCount,
                    ),
                    SizedBox(height: 20.h),
                    MonthlyPatientsChart(
                      color: const Color(0xFF5AC8FB),
                      title: appLocalizations.monthlyRentals,
                      data: List.generate(
                        data.monthNames.length,
                            (index) => MonthlyPatient(
                          month: index + 1,
                          count: data.monthlyRentals[index],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    MonthlyPatientsChart(
                      color: const Color(0xFF87DD68),
                      title: appLocalizations.monthlyBookings,
                      data: List.generate(
                        data.monthNames.length,
                            (index) => MonthlyPatient(
                          month: index + 1,
                          count: data.monthlyBookings[index],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}