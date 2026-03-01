import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class CustomDepartmentHospitals extends StatelessWidget {
  final List<String> departments;

  const CustomDepartmentHospitals({super.key, required this.departments});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final uniqueDepartments = departments.toSet().toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.departments,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 92.h,
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            itemCount: uniqueDepartments.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              padding: REdgeInsets.symmetric(horizontal: 25, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: ColorManager.lightBlue,
              ),
              child: Column(
                children: [
                  Container(
                    padding: REdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ColorManager.darkBlue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      getDepartmentIcon(uniqueDepartments[index]),
                      size: 29,
                      color: ColorManager.secondary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    uniqueDepartments[index],
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: ColorManager.darkBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  IconData getDepartmentIcon(String department) {
    switch (department.toLowerCase()) {
      case 'cardiology':
        return Icons.monitor_heart;

      case 'surgery':
        return Icons.medical_services;

      case 'pediatrics':
        return Icons.child_care;

      case 'oncology':
        return Icons.biotech;

      case 'neurology':
      case 'neurology & neurosurgery':
        return Icons.psychology_outlined;

      case 'psychiatric':
        return Icons.psychology_alt;

      case 'emergency':
        return Icons.local_hospital;

      case 'ophthalmology':
        return Icons.remove_red_eye;

      case 'ent':
      case 'ophthalmology & ent':
        return Icons.hearing;

      case 'orthopedics':
        return Icons.accessibility_new;

      case 'internal medicine':
      case 'general medicine':
        return Icons.health_and_safety_outlined;

      case 'infectious diseases':
      case 'contagious diseases':
        return Icons.coronavirus_outlined;

      case 'research':
        return Icons.science_outlined;

      case 'pulmonology':
      case 'chest diseases':
        return Icons.air;

      case 'obstetrics & gynecology':
        return Icons.pregnant_woman;

      case 'neonatology':
        return Icons.baby_changing_station;

      case 'trauma':
        return Icons.warning;

      default:
        return Icons.local_hospital_outlined;
    }
  }

}

