import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/booking/data/model/booking_model.dart';

class DapartmentSelector extends StatelessWidget {
  final List<DepartmentModel> departments;
  final int selectedDepartmentId;
  final Function(int) onDepartmentSelected;

  const DapartmentSelector({
    super.key,
    required this.departments,
    required this.selectedDepartmentId,
    required this.onDepartmentSelected,
  });

  @override
  Widget build(BuildContext context) {
    final uniqueDepartments = <String, DepartmentModel>{};
    for (var dept in departments) {
      uniqueDepartments[dept.name.toLowerCase()] ??= dept;
    }

    final finalDepartments = uniqueDepartments.values.toList();

    return SizedBox(
      height: 110.h,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: finalDepartments.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final department = finalDepartments[index];
          final isSelected = department.departmentId == selectedDepartmentId;
          return GestureDetector(
            onTap: () => onDepartmentSelected(department.departmentId),
            child: Container(
              width: 100.w,
              padding: REdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: ColorManager.lightBlue,
                borderRadius: BorderRadius.circular(27.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: REdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ColorManager.darkBlue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      getDepartmentIcon(department.name),
                      size: 26.sp,
                      color: ColorManager.secondary,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    department.name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: ColorManager.darkBlue,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  IconData getDepartmentIcon(String department) {
    switch (department.toLowerCase()) {
      case 'cardiology':
        return Icons.favorite_border_rounded;
      case 'neurology':
      case 'neurology & neurosurgery':
        return Icons.psychology_outlined;
      case 'pediatrics':
        return Icons.child_care_rounded;
      case 'oncology':
        return Icons.biotech_outlined;
      case 'orthopedics':
        return Icons.personal_injury_outlined;
      case 'ophthalmology':
      case 'ophthalmology & ent':
        return Icons.visibility_outlined;
      case 'general':
      case 'general medicine':
        return Icons.medical_services_outlined;
      case 'chest diseases':
        return Icons.local_fire_department_outlined;
      case 'emergency':
        return Icons.warning_amber_outlined;
      case 'surgery':
      case 'pediatric surgery':
        return Icons.healing_outlined;
      case 'psychiatric':
      case 'psychiatric & neurology':
        return Icons.psychology_alt_outlined;
      case 'contagious diseases':
      case 'infectious diseases':
        return Icons.coronavirus_outlined;
      case "children's cancer":
        return Icons.child_friendly_outlined;
      case 'neonatology':
        return Icons.child_care_outlined;
      case 'internal medicine':
        return Icons.local_hospital_outlined;
      case 'pulmonology':
        return Icons.air_outlined;
      case 'obstetrics & gynecology':
        return Icons.pregnant_woman_outlined;
      case 'trauma':
        return Icons.local_hospital_outlined;
      case 'psychiatry':
        return Icons.psychology_alt_outlined;
      case 'specialist':
        return Icons.medical_services_outlined;
      default:
        return Icons.local_hospital_outlined;
    }
  }
}
