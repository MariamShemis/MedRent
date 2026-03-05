import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class SpecialtiesDropdown extends StatefulWidget {
  const SpecialtiesDropdown({super.key});

  @override
  State<SpecialtiesDropdown> createState() => _SpecialtiesDropdownState();
}

class _SpecialtiesDropdownState extends State<SpecialtiesDropdown> {
  bool isExpanded = false;
  String? selectedValue;

  final List<String> items = [
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
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => isExpanded = !isExpanded),
          child: Container(
            width: 166.w,

            padding: REdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: ColorManager.lightGrey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Specialties",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: ColorManager.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: isExpanded
                      ? ColorManager.secondary
                      : ColorManager.black,
                  size: 30.sp,
                ),
              ],
            ),
          ),
        ),

        if (isExpanded)
          Container(
            width: 180.w,
            margin: EdgeInsets.only(top: 4.h),
            padding: REdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: ColorManager.lightGrey),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10),
              ],
            ),
            child: Column(
              children: items.map((item) {
                final isSelected = selectedValue == item;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedValue = item;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: REdgeInsets.symmetric(vertical: 14, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? ColorManager.darkBlue
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isSelected)
                          Icon(Icons.check, color: Colors.white, size: 20.sp),
                        if (isSelected) SizedBox(width: 6.w),
                        Text(
                          item,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: isSelected
                                ? Colors.white
                                : ColorManager.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
