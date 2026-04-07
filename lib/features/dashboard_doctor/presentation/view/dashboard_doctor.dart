import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/features/dashboard_doctor/presentation/widgets/appointment_pie_chart.dart';
import 'package:med_rent/features/dashboard_doctor/presentation/widgets/dashboard_state_card.dart';
import 'package:med_rent/features/dashboard_doctor/presentation/widgets/monthly_patients_chart.dart';
import 'package:med_rent/features/dashboard_doctor/presentation/widgets/weekly_reservations_chart.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
      body: SingleChildScrollView(
        padding: REdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DashboardStatCard(
                    value: "1248",
                    title: appLocalizations.totalPatients,
                    icon: Icons.group_outlined,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: DashboardStatCard(
                    value: "18",
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
                    value: "4",
                    title: appLocalizations.pendingPatients,
                    icon: Iconsax.timer_14,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: DashboardStatCard(
                    value: "94%",
                    title: appLocalizations.satisfactionRate,
                    icon: Iconsax.chart_1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            WeeklyReservationsChart(color: Color(0xFFB2E2E2),),
            const SizedBox(height: 20),
            AppointmentPieChart(),
            const SizedBox(height: 20),
            MonthlyPatientsChart(color: Color(0xFF6080DB),),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
