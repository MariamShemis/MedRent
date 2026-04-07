import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class MonthlyPatientsChart extends StatelessWidget {
  const MonthlyPatientsChart({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 4,
      shadowColor: Colors.black26,
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              appLocalizations.monthlyPatients,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              height: 200.h,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 200,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      left: BorderSide(color: Colors.grey.shade400, width: 1.5),
                      bottom: BorderSide(
                        color: Colors.grey.shade400,
                        width: 1.5,
                      ),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          const months = [
                            'Janu',
                            'Febr',
                            'Marc',
                            'April',
                            'May',
                            'June',
                          ];
                          return SideTitleWidget(
                            meta: meta,
                            space: 8,
                            child: Text(
                              months[value.toInt()],
                              style: Theme.of(context).textTheme.headlineMedium!
                                  .copyWith(fontSize: 14.sp),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 35,
                        interval: 50,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: Theme.of(context).textTheme.headlineMedium!
                                .copyWith(fontSize: 14.sp),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    _bar(0, 140),
                    _bar(1, 185),
                    _bar(2, 80),
                    _bar(3, 15),
                    _bar(4, 55),
                    _bar(5, 150),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _bar(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 38,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
    );
  }
}
