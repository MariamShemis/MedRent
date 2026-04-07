import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class AppointmentPieChartAdmin extends StatelessWidget {
  const AppointmentPieChartAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final data = [
      {'title': appLocalizations.cardiologyConsultation, 'value': 56.0, 'color': const Color(0xFF079E6B)},
      {'title': appLocalizations.followup, 'value': 30.0, 'color': const Color(0xFF61E076)},
      {'title': appLocalizations.general_Checkup, 'value': 39.0, 'color': Color(0xFFE90509)},
      {'title': appLocalizations.consultation, 'value': 49.0, 'color': const Color(0xFF4786FB)},
      {'title': appLocalizations.emergency, 'value': 63.0, 'color': const Color(0xFFE08261)},
    ];
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
                  startDegreeOffset: -90,
                  sections: data.map((item) {
                    return PieChartSectionData(
                      value: item['value'] as double,
                      color: item['color'] as Color,
                      radius: 40.r,
                      showTitle: true,
                      title: item['value'].toString().split('.')[0],
                      titlePositionPercentageOffset: 1.4,
                      titleStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF4556FE),
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