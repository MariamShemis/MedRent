import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class WeeklyReservationsChart extends StatelessWidget {
  const WeeklyReservationsChart({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                  maxY: 28,
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (touchedSpot) =>
                          Colors.blueGrey.withOpacity(0.8),
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((spot) {
                          return LineTooltipItem(
                            '${spot.y.toInt()}',
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: 7,
                    verticalInterval: 1,
                    getDrawingHorizontalLine: (value) =>
                        FlLine(color: Colors.grey.shade300, strokeWidth: 1.5),
                    getDrawingVerticalLine: (value) =>
                        FlLine(color: Colors.grey.shade300, strokeWidth: 1.5),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black.withOpacity(0.8),
                        width: 2,
                      ),
                      left: BorderSide(
                        color: Colors.black.withOpacity(0.8),
                        width: 2,
                      ),
                      right: const BorderSide(color: Colors.transparent),
                      top: const BorderSide(color: Colors.transparent),
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
                        interval: 7,
                        reservedSize: 35,
                        getTitlesWidget: (value, meta) => SideTitleWidget(
                          meta: meta,
                          child: Text(
                            value.toInt().toString(),
                            style: Theme.of(context).textTheme.headlineMedium!
                                .copyWith(fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 35,
                        getTitlesWidget: (value, meta) {
                          const days = [
                            'Sate',
                            'Sun',
                            'Mon',
                            'Tues',
                            'Wed',
                            'Thur',
                            'Fri',
                          ];
                          if (value >= 0 && value < days.length) {
                            return SideTitleWidget(
                              meta: meta,
                              space: 10,
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
                      barWidth: 4,
                      color: color,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: color?.withOpacity(0.4),
                      ),
                      spots: const [
                        FlSpot(0, 0),
                        FlSpot(1, 15),
                        FlSpot(2, 13),
                        FlSpot(3, 20),
                        FlSpot(4, 15),
                        FlSpot(5, 16),
                        FlSpot(6, 0),
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
