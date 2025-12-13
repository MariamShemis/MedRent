import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key, required this.hintText, required this.iconPrefix , this.onChanged});
  final String hintText;
  final IconData iconPrefix;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.labelSmall,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Icon(iconPrefix , color: ColorManager.greyText,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(width: 1, color: ColorManager.secondary.withValues(alpha: 0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(width: 1 , color: ColorManager.secondary.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(width: 1 , color: ColorManager.secondary.withValues(alpha: 0.5)),
        ),
      ),
    );
  }
}
