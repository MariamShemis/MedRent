import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class WeeklyReservationsChartAdmin extends StatelessWidget {
  final List<String> days;
  final List<int> bookings;

  const WeeklyReservationsChartAdmin({
    super.key,
    required this.days,
    required this.bookings,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    double maxVal = bookings.isEmpty
        ? 100
        : bookings.reduce((a, b) => a > b ? a : b).toDouble() + 20;
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
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: maxVal,
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
                      bottom: BorderSide(
                        color: Colors.grey.shade400,
                        width: 1.5,
                      ),
                      left: BorderSide(color: Colors.grey.shade400, width: 1.5),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
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
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index >= 0 && index < days.length) {
                            return SideTitleWidget(
                              meta: meta,
                              child: Text(
                                days[index],
                                style: TextStyle(fontSize: 10.sp),
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
                      color: const Color(0xFF90CEC7),
                      belowBarData: BarAreaData(
                        show: true,
                        color: const Color(0xFF90CEC7).withOpacity(0.3),
                      ),
                      spots: List.generate(
                        bookings.length,
                        (i) => FlSpot(i.toDouble(), bookings[i].toDouble()),
                      ),
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
