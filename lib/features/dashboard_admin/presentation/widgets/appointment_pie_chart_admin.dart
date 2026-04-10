import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class AppointmentPieChartAdmin extends StatelessWidget {
  final List<String> names;
  final List<int> counts;

  const AppointmentPieChartAdmin({
    super.key,
    required this.names,
    required this.counts,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final List<Map<String, dynamic>> data = List.generate(names.length, (index) {
      return {
        'title': names[index],
        'value': counts[index].toDouble(),
        'color': Colors.primaries[index % Colors.primaries.length],
      };
    });
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      elevation: 4,
      child: Padding(
        padding: REdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              appLocalizations.types_of_Appointments,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              height: 240.h,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 60.r,
                  sections: data.map((item) {
                    return PieChartSectionData(
                      value: item['value'],
                      color: item['color'],
                      radius: 40.r,
                      showTitle: true,
                      title: item['value'].toStringAsFixed(0),
                      titleStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            _buildLegendGrid(data),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendGrid(List<Map<String, dynamic>> data) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 25,
        mainAxisExtent: 30,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Container(
              width: 18.w,
              height: 18.h,
              decoration: BoxDecoration(
                color: data[index]['color'] as Color,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                data[index]['title'] as String,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 12.sp),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }
}