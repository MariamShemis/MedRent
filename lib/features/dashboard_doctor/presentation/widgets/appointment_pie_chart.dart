import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class AppointmentPieChart extends StatefulWidget {
  const AppointmentPieChart({super.key});

  @override
  State<AppointmentPieChart> createState() => _AppointmentPieChartState();
}

class _AppointmentPieChartState extends State<AppointmentPieChart> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 4,
      shadowColor: Colors.black26,
      child: Padding(
        padding: REdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              appLocalizations.types_of_Appointments,
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 180.h,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 0,
                  sections: [
                    PieChartSectionData(
                      value: 45,
                      color: const Color(0xFF5EA1C2),
                      showTitle: false,
                      radius: 80.r,
                    ),
                    PieChartSectionData(
                      value: 30,
                      color: const Color(0xFFE28361),
                      showTitle: false,
                      radius: 80.r,
                    ),
                    PieChartSectionData(
                      value: 15,
                      color: const Color(0xFF5D7DD8),
                      showTitle: false,
                      radius: 80.r,
                    ),
                    PieChartSectionData(
                      value: 10,
                      color: const Color(0xFFD75795),
                      showTitle: false,
                      radius: 80.r,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            _legendItem(const Color(0xFF5EA1C2), appLocalizations.general_Checkup, "45%"),
            _legendItem(const Color(0xFFE28361), appLocalizations.followup, "30%"),
            _legendItem(const Color(0xFFD75795), appLocalizations.consultation, "10%"),
            _legendItem(const Color(0xFF5D7DD8), appLocalizations.emergency, "15%"),
          ],
        ),
      ),
    );
  }

  Widget _legendItem(Color color, String title, String percentage) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 18.w,
            height: 18.h,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.displayLarge!.copyWith(fontSize: 16.sp),
            ),
          ),
          Text(
            percentage,
            style: Theme.of(
              context,
            ).textTheme.displayLarge!.copyWith(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
