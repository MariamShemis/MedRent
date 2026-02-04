import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/main_layout/profile/presentation/widgets/container_profile_item.dart';

class CustomProfileContainerItem extends StatelessWidget {
  const CustomProfileContainerItem({super.key, required this.onPressedIconArrow1, required this.onPressedIconArrow2, required this.onPressedIconArrow3, required this.onPressedIconArrow4});
  final VoidCallback onPressedIconArrow1;
  final VoidCallback onPressedIconArrow2;
  final VoidCallback onPressedIconArrow3;
  final VoidCallback onPressedIconArrow4;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      color: ColorManager.white,
      margin: REdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: REdgeInsets.all(10.0),
        child: Column(
          children: [
            ContainerProfileItem(
              iconPrefix: Iconsax.user_square,
              iconSuffixArrow: Icons.arrow_forward_ios,
              text: "Personal Information",
              onPressedIconArrow: onPressedIconArrow1,
            ),
            SizedBox(height: 10.h,),
            ContainerProfileItem(
              iconPrefix: Iconsax.calendar_1,
              iconSuffixArrow: Icons.arrow_forward_ios,
              text: "My Booking",
              onPressedIconArrow: onPressedIconArrow2,
            ),
            SizedBox(height: 10.h,),
            ContainerProfileItem(
              iconPrefix: Iconsax.box_search,
              iconSuffixArrow: Icons.arrow_forward_ios,
              text: "My Rentals",
              onPressedIconArrow: onPressedIconArrow3,
            ),
            SizedBox(height: 10.h,),
            ContainerProfileItem(
              iconPrefix: Iconsax.notification,
              iconSuffixArrow: Icons.arrow_forward_ios,
              text: "Notification Settings",
              onPressedIconArrow: onPressedIconArrow4,
            ),
            SizedBox(height: 10.h,),

          ],
        ),
      ),
    );
  }
}
