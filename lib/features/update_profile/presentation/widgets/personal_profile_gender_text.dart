import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class PersonalProfileGenderText extends StatelessWidget {
  const PersonalProfileGenderText({
    super.key,
    required this.selectedLabel,
    required this.menuItems,
    this.onChange,
    this.isGender = true,
  });

  final String selectedLabel;
  final List<String> menuItems;
  final void Function(String?)? onChange;
  final bool isGender;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        border: Border.all(
          color: isGender ? ColorManager.greyText : ColorManager.lightGrey,
          width: isGender ? 1.2 : 1.5,
        ),
        borderRadius: BorderRadius.circular(isGender ? 18.r : 16.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedLabel,
          selectedItemBuilder: (BuildContext context) {
            return menuItems.map((String item) {
              return Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: isGender ? FontWeight.w900 : FontWeight.w500,
                    fontSize: isGender ? 16.sp : 14.sp,
                    color: ColorManager.darkGrey,
                  ),
                ),
              );
            }).toList();
          },
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          dropdownColor: ColorManager.white,
          borderRadius: BorderRadius.circular(18.r),
          items: menuItems.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: isGender ? FontWeight.w900 : FontWeight.w500,
                  fontSize: isGender ? 16.sp : 14.sp,
                  color: ColorManager.black,
                ),
              ),
            );
          }).toList(),
          onChanged: onChange,
        ),
      ),
    );
  }
}
