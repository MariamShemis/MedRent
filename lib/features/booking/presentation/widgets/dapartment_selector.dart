import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return SizedBox(
      height: 110.h,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: departments.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final department = departments[index];
          final isSelected = department.departmentId == selectedDepartmentId;

          return GestureDetector(
            onTap: () => onDepartmentSelected(department.departmentId),
            child: Container(
              width: 100.w,
              padding: REdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color:  
                    ColorManager.lightBlue,
                borderRadius: BorderRadius.circular(16.r),
              
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: REdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:  ColorManager.darkBlue,
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
                    style: TextStyle(
                      fontSize: 13.sp,
                      color:ColorManager.darkBlue,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
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
        return Icons.psychology_outlined; 
      case 'pediatrics':
        return Icons.child_care_rounded;
      case 'oncology':
        return Icons.biotech_outlined;
      case 'orthopedics':
        return Icons.personal_injury_outlined;
      case 'ophthalmology':
        return Icons.visibility_outlined;
      case 'general':
        return Icons.medical_services_outlined;
      default:
        return Icons.local_hospital_outlined;
    }
  }
}