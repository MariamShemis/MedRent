import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/booking/data/model/booking_model.dart';

class SpecialtiesDropdown extends StatefulWidget {
  final List<DepartmentModel> departments;
  final int selectedDepartmentId;
  final Function(int) onSpecialtySelected;

  const SpecialtiesDropdown({
    super.key,
    required this.departments,
    required this.selectedDepartmentId,
    required this.onSpecialtySelected,
  });

  @override
  State<SpecialtiesDropdown> createState() => _SpecialtiesDropdownState();
}

class _SpecialtiesDropdownState extends State<SpecialtiesDropdown> {
  bool isExpanded = false;

  String getSelectedValue() {
    try {
      return widget.departments
          .firstWhere((d) => d.departmentId == widget.selectedDepartmentId)
          .name;
    } catch (e) {
      return 'Specialties';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => isExpanded = !isExpanded),
          child: Container(
            width: 180.w,
            padding: REdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: ColorManager.greyText , width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    getSelectedValue(),
                    style: Theme.of(context).textTheme.labelLarge
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: isExpanded ? ColorManager.secondary : ColorManager.black,
                  size: 30.sp,
                ),
              ],
            ),
          ),
        ),
        // if (isExpanded)
        //   Container(
        //     width: 180.w,
        //     margin: EdgeInsets.only(top: 4.h),
        //     padding: REdgeInsets.all(4),
        //     decoration: BoxDecoration(
        //       color: Colors.transparent,
        //       borderRadius: BorderRadius.circular(10.r),
        //       border: Border.all(color: ColorManager.greyText),
        //       boxShadow: [
        //         BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10),
        //       ],
        //     ),
        //     child: Column(
        //       children: widget.departments.map((department) {
        //         final isSelected = department.departmentId == widget.selectedDepartmentId;
        //         return GestureDetector(
        //           onTap: () {
        //             widget.onSpecialtySelected(department.departmentId);
        //             setState(() => isExpanded = false);
        //           },
        //           child: Container(
        //             width: double.infinity,
        //             padding: REdgeInsets.symmetric(vertical: 14, horizontal: 8),
        //             decoration: BoxDecoration(
        //               color: isSelected ? ColorManager.darkBlue : Colors.transparent,
        //               borderRadius: BorderRadius.circular(6.r),
        //             ),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 if (isSelected)
        //                   Icon(Icons.check, color: Colors.white, size: 20.sp),
        //                 if (isSelected) SizedBox(width: 6.w),
        //                 Expanded(
        //                   child: Text(
        //                     department.name,
        //                     style: Theme.of(context).textTheme.labelMedium!.copyWith(
        //                       color: isSelected ? Colors.white : ColorManager.black,
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         );
        //       }).toList(),
        //     ),
        //   ),
        if (isExpanded)
          Container(
            width: 180.w,
            constraints: BoxConstraints(
              maxHeight: 300.h,
            ),
            margin: EdgeInsets.only(top: 4.h),
            padding: REdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: ColorManager.greyText),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: widget.departments.map((department) {
                  final isSelected =
                      department.departmentId == widget.selectedDepartmentId;
                  return GestureDetector(
                    onTap: () {
                      widget.onSpecialtySelected(department.departmentId);
                      setState(() => isExpanded = false);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: REdgeInsets.symmetric(vertical: 14, horizontal: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? ColorManager.darkBlue : Colors.transparent,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isSelected)
                            Icon(Icons.check, color: Colors.white, size: 20.sp),
                          if (isSelected) SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              department.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: isSelected ? Colors.white : ColorManager.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          )
      ],
    );
  }
}