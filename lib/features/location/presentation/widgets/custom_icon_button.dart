import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.isWhite,
    required this.onTap,
  });

  final IconData icon;
  final bool isWhite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isWhite ? ColorManager.white : Colors.transparent,
          shape: BoxShape.circle,
          border: isWhite ? null : BoxBorder.all(
            color: ColorManager.greyText,
            width: 1.5.w,
          ),
        ),
        child: Icon(icon, color: ColorManager.black),
      ),
    );
  }
}
