import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/main_layout/profile/presentation/widgets/container_profile_item.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class CustomProfileContainerItem extends StatelessWidget {
  const CustomProfileContainerItem({super.key, required this.onPressedIconArrow1, required this.onPressedIconArrow2, required this.onPressedIconArrow3, required this.onPressedIconArrow4, required this.onPressedIconArrowContactUs});
  final VoidCallback onPressedIconArrow1;
  final VoidCallback onPressedIconArrow2;
  final VoidCallback onPressedIconArrow3;
  final VoidCallback onPressedIconArrow4;
  final VoidCallback onPressedIconArrowContactUs;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      color: ColorManager.white,
      margin: REdgeInsets.symmetric(vertical: 8 , horizontal: 12),
      child: Padding(
        padding: REdgeInsets.all(10.0),
        child: Column(
          children: [
            ContainerProfileItem(
              iconPrefix: Iconsax.user_square,
              iconSuffixArrow: Icons.arrow_forward_ios,
              text: appLocalizations.personalInformation,
              onPressedIconArrow: onPressedIconArrow1,
            ),
            SizedBox(height: 5.h,),
            ContainerProfileItem(
              iconPrefix: Iconsax.calendar_1,
              iconSuffixArrow: Icons.arrow_forward_ios,
              text: appLocalizations.myBooking,
              onPressedIconArrow: onPressedIconArrow2,
            ),
            SizedBox(height: 10.h,),
            ContainerProfileItem(
              iconPrefix: Iconsax.calendar5,
              iconSuffixArrow: Icons.arrow_forward_ios,
              text: appLocalizations.contactUs,
              onPressedIconArrow: onPressedIconArrowContactUs,
            ),
            SizedBox(height: 10.h,),
            ContainerProfileItem(
              iconPrefix: Iconsax.box_search,
              iconSuffixArrow: Icons.arrow_forward_ios,
              text: appLocalizations.myRentals,
              onPressedIconArrow: onPressedIconArrow3,
            ),
            SizedBox(height: 10.h,),
            ContainerProfileItem(
              iconPrefix: Iconsax.notification,
              iconSuffixArrow: Icons.arrow_forward_ios,
              text: appLocalizations.notificationSettings,
              onPressedIconArrow: onPressedIconArrow4,
            ),
            SizedBox(height: 10.h,),

          ],
        ),
      ),
    );
  }
}
