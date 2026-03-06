
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class DapartmentSelector extends StatelessWidget {
  const DapartmentSelector({super.key});

  final List<String> departments = const [
    'Cardiology',
    'Neurology',
    'Pediatrics',
    'Oncology',
    'Orthopedics',
    'Ophthalmology',
    'General',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: departments.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final deptName = departments[index];

          return Container(
            width: 100.w,
            padding: REdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: ColorManager.lightBlue,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: REdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: ColorManager.darkBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    getDepartmentIcon(deptName),
                    size: 26.sp,
                    color: ColorManager.secondary,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  deptName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: ColorManager.darkBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData getDepartmentIcon(String department) {
    switch (department.toLowerCase()) {
      case 'cardiology':
        return Icons.favorite_border_rounded; // أيقونة القلب المفرغ
      case 'neurology':
        return Icons.psychology_outlined; 
      case 'pediatrics':
        return Icons.child_care_rounded;
      case 'oncology':
        return Icons.biotech_outlined;
      case 'orthopedics':
        return Icons.personal_injury_outlined; // أقرب شكل للعظام في Material
      case 'ophthalmology':
        return Icons.visibility_outlined; // أيقونة العين المفرغة
      case 'general':
        return Icons.medical_services_outlined; // أيقونة الشنطة الطبية

      default:
        return Icons.local_hospital_outlined;
    }
  }
}