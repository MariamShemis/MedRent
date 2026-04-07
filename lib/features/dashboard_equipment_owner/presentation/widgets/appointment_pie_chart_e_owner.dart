import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class AppointmentPieChartEOwner extends StatefulWidget {
  const AppointmentPieChartEOwner({super.key});

  @override
  State<AppointmentPieChartEOwner> createState() => _AppointmentPieChartEOwnerState();
}

class _AppointmentPieChartEOwnerState extends State<AppointmentPieChartEOwner> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
      elevation: 5,
      shadowColor: Colors.black12,
      child: Padding(
        padding: REdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              appLocalizations.types_of_Appointments,
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              height: 180.h,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 55.r,
                  sections: [
                    PieChartSectionData(
                      value: 45,
                      color: const Color(0xFF5BC080),
                      radius: 35.r,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      value: 30,
                      color: const Color(0xFFE28361),
                      radius: 35.r,
                      showTitle: false,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            _buildLegendItem(appLocalizations.dailyRent, "45%", const Color(0xFF5BC080)),
            SizedBox(height: 12.h),
            _buildLegendItem(appLocalizations.weeklyRent, "30%", const Color(0xFFE28361)),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String title, String percentage, Color color) {
    return Row(
      children: [
        Container(
          width: 16.w,
          height: 16.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 15.w),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.displayLarge!.copyWith(fontSize: 16.sp),
        ),
        const Spacer(),
        Text(
          percentage,
          style: Theme.of(
            context,
          ).textTheme.displayLarge!.copyWith(fontSize: 16.sp),
        ),
      ],
    );
  }
}
