import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/main_layout/profile/data/models/profile_menu_item.dart';
import 'package:med_rent/features/main_layout/profile/presentation/widgets/container_profile_item.dart';


class CustomProfileContainerItem extends StatelessWidget {
  const CustomProfileContainerItem({
    super.key,
    required this.items,
  });

  final List<ProfileMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      surfaceTintColor: ColorManager.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      color: ColorManager.white,
      margin: REdgeInsets.symmetric(vertical: 6 , horizontal: 3),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 10.0 , vertical: 18),
        child: Column(
          children: List.generate(items.length, (index) {
            final item = items[index];
            return Padding(
              padding: REdgeInsets.only(bottom: index == items.length - 1 ? 0 : 14.h),
              child: ContainerProfileItem(
                iconPrefix: item.icon,
                iconSuffixArrow: Icons.arrow_forward_ios,
                isLanguage: item.isLanguage,
                textLanguage: item.textLanguage,
                text: item.text,
                onPressedIconArrow: item.onPressed,
              ),
            );
          }),
        ),
      ),
    );
  }
}
