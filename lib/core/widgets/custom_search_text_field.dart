import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({
    super.key,
    required this.hintText,
    this.iconPrefix,
    this.onChanged,
    this.maxLines = 1,
    this.isDarkColor = false,
    this.iconSuffix,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.isFocus = false,
  });

  final String hintText;
  final IconData? iconPrefix;
  final Widget? iconSuffix;
  final int maxLines;
  final bool isDarkColor;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool isFocus;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      onTap: onTap,
      autofocus: isFocus,
      controller: controller,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.labelSmall,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        suffixIcon: iconSuffix,
        prefixIcon: isDarkColor
            ? null
            : Icon(iconPrefix, color: ColorManager.greyText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            width: 1,
            color: isDarkColor
                ? ColorManager.darkBlue
                : ColorManager.secondary.withValues(alpha: 0.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            width: 1,
            color: isDarkColor
                ? ColorManager.darkBlue
                : ColorManager.secondary.withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            width: 1,
            color: isDarkColor
                ? ColorManager.darkBlue
                : ColorManager.secondary.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}
