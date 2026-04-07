import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class WeeklyReservationsChartAdmin extends StatelessWidget {
  const WeeklyReservationsChartAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
      elevation: 6,
      child: Padding(
        padding: REdgeInsets.fromLTRB(16, 20, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              appLocalizations.weekly_reservations,
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 25.h),
            SizedBox(
              height: 220.h,
              child:
              LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 300,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: 75,
                    verticalInterval: 1,
                    getDrawingHorizontalLine: (value) =>
                        FlLine(color: Colors.grey, strokeWidth: 2),
                    getDrawingVerticalLine: (value) =>
                        FlLine(color: Colors.grey, strokeWidth: 2),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade400, width: 1.5),
                      left: BorderSide(color: Colors.grey.shade400, width: 1.5),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 75,
                        reservedSize: 28.w,
                        getTitlesWidget: (value, meta) => SideTitleWidget(
                          meta: meta,
                          space: 4.w,
                          child: Text(
                            value.toInt().toString(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          const days = ['Sate', 'Su', 'Mo', 'Tue', 'Wed', 'Thu', 'Fri'];
                          if (value >= 0 && value < days.length) {
                            return SideTitleWidget(
                              meta: meta,
                              space: 8,
                              child: Text(
                                days[value.toInt()],
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontSize: 14.sp),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      curveSmoothness: 0.35,
                      barWidth: 0,
                      color: const Color(0xFF90CEC7),
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: const Color(0xFF90CEC7).withOpacity(0.8),
                      ),
                      spots: const [
                        FlSpot(0, 150),
                        FlSpot(1, 230),
                        FlSpot(2, 170),
                        FlSpot(3, 240),
                        FlSpot(4, 200),
                        FlSpot(5, 240),
                        FlSpot(6, 170),
                      ],
                    ),
                    LineChartBarData(
                      isCurved: false,
                      barWidth: 0,
                      color: const Color(0xFF9F8781),
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: const Color(0xFF9F8781).withOpacity(0.7),
                      ),
                      spots: const [
                        FlSpot(0, 75),
                        FlSpot(1, 160),
                        FlSpot(2, 115),
                        FlSpot(3, 160),
                        FlSpot(4, 110),
                        FlSpot(5, 180),
                        FlSpot(6, 110),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}