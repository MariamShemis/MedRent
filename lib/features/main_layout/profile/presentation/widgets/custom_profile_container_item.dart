import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/main_layout/profile/presentation/widgets/container_profile_item.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class CustomProfileContainerItem extends StatelessWidget {
  const CustomProfileContainerItem({
    super.key,
    required this.onPressedIconPersonalInformation,
    required this.onPressedIconMyRental,
    required this.onPressedNotification,
    required this.onPressedIconContactUs,
    required this.onPressedLanguage,
    this.textLanguage,
  });

  final VoidCallback onPressedIconPersonalInformation;
  final VoidCallback onPressedIconMyRental;
  final VoidCallback onPressedNotification;
  final VoidCallback onPressedLanguage;
  final VoidCallback onPressedIconContactUs;
  final String? textLanguage;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      color: ColorManager.white,
      margin: REdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 10.0 , vertical: 18),
        child: Column(
          children: [
            ContainerProfileItem(
              iconPrefix: Iconsax.user_edit4,
              iconSuffixArrow: Icons.arrow_forward_ios,
              text: appLocalizations.personalInformation,
              onPressedIconArrow: onPressedIconPersonalInformation,
            ),
            SizedBox(height: 14.h),
            ContainerProfileItem(
              iconPrefix: Iconsax.calendar_1,
              iconSuffixArrow: Icons.arrow_forward_ios,
              text: appLocalizations.contactUs,
              onPressedIconArrow: onPressedIconContactUs,
            ),
            SizedBox(height: 14.h),
            ContainerProfileItem(
              iconPrefix: Iconsax.box_search,
              iconSuffixArrow: Icons.arrow_forward_ios,
              text: appLocalizations.myRentals,
              onPressedIconArrow: onPressedIconMyRental,
            ),
            SizedBox(height: 14.h),
            ContainerProfileItem(
              iconPrefix: Iconsax.notification,
              iconSuffixArrow: Icons.arrow_forward_ios,
              text: appLocalizations.notificationSettings,
              onPressedIconArrow: onPressedNotification,
            ),
            SizedBox(height: 14.h),
            ContainerProfileItem(
              iconPrefix: Icons.language_outlined,
              iconSuffixArrow: Icons.arrow_forward_ios,
              isLanguage: true,
              textLanguage: textLanguage,
              text: appLocalizations.language,
              onPressedIconArrow: onPressedLanguage,
            ),
          ],
        ),
      ),
    );
  }
}
