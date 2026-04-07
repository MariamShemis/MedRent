import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/features/dashboard_doctor/data/models/dashboard_model.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class AppointmentPieChart extends StatelessWidget {
  const AppointmentPieChart({super.key, required this.data});

  final List<BookingType> data;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final colors = [
      const Color(0xFF5EA1C2),
      const Color(0xFFE28361),
      const Color(0xFF5D7DD8),
      const Color(0xFFD75795),
    ];

    final total = data.fold<int>(0, (sum, e) => sum + e.count);

    String percent(int value) {
      if (total == 0) return "0%";
      return "${((value / total) * 100).toStringAsFixed(0)}%";
    }

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

            SizedBox(height: 20.h),

            SizedBox(
              height: 180.h,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 0,
                  sections: data.isEmpty
                      ? [
                          PieChartSectionData(
                            value: 1,
                            color: Colors.grey,
                            showTitle: false,
                            radius: 80.r,
                          ),
                        ]
                      : List.generate(data.length, (index) {
                          return PieChartSectionData(
                            value: data[index].count.toDouble(),
                            color: colors[index % colors.length],
                            showTitle: false,
                            radius: 80.r,
                          );
                        }),
                ),
              ),
            ),

            SizedBox(height: 30.h),

            if (data.isEmpty)
              _legendItem(Colors.grey, "No Data", "0%", context)
            else
              ...List.generate(data.length, (index) {
                final item = data[index];
                return _legendItem(
                  colors[index % colors.length],
                  item.type,
                  percent(item.count),
                  context,
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _legendItem(
    Color color,
    String title,
    String percentage,
    BuildContext context,
  ) {
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
