import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class PersonalProfileGenderText extends StatelessWidget {
  const PersonalProfileGenderText({super.key, required this.selectedLabel, required this.menuItems, this.onChange});
  final String selectedLabel;
  final List<String> menuItems;
  final void Function(String?)? onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: ColorManager.white,
        border: BoxBorder.all(color: ColorManager.greyText, width: 1.2),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [
          Text(
            selectedLabel,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w900,
              color: ColorManager.darkGrey,
            ),
          ),
          Spacer(),
          DropdownButton(
            dropdownColor: ColorManager.white,
            iconSize: 35.sp,
            underline: Container(),
            icon: Icon(Icons.keyboard_arrow_down_outlined),
            items: menuItems.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}
