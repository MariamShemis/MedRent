import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/features/dashboard_equipment_owner/data/models/equipment_owner_dashboard_model.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class AppointmentPieChartEOwner extends StatelessWidget {
  final List<RentalType> rentalTypes;
  const AppointmentPieChartEOwner({super.key, required this.rentalTypes});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    double total = rentalTypes.fold(0, (sum, item) => sum + item.count);
    List<PieChartSectionData> sections = [];
    List<Color> colors = [const Color(0xFF5BC080), const Color(0xFFE28361), const Color(0xFFDB60CD)];

    for (int i = 0; i < rentalTypes.length; i++) {
      final value = total == 0 ? 0.0 : (rentalTypes[i].count / total) * 100;
      sections.add(PieChartSectionData(
        value: value,
        color: colors[i % colors.length],
        radius: 35.r,
        showTitle: false,
      ));
    }

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
              style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              height: 180.h,
              child: PieChart(PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 55.r,
                sections: sections,
              )),
            ),
            SizedBox(height: 30.h),
            Column(
              children: List.generate(rentalTypes.length, (index) {
                final percentage = total == 0 ? "0%" : "${((rentalTypes[index].count / total) * 100).toStringAsFixed(0)}%";
                final color = colors[index % colors.length];
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _buildLegendItem(context, rentalTypes[index].type, percentage, color),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, String title, String percentage, Color color) {
    return Row(
      children: [
        Container(width: 16.w, height: 16.w, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 15.w),
        Text(title, style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 16.sp)),
        const Spacer(),
        Text(percentage, style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 16.sp)),
      ],
    );
  }
}
