import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/assets_manager.dart';
import 'package:med_rent/core/widgets/custom_search_text_field.dart';
import 'package:med_rent/features/main_layout/home/presentation/widgets/custom_container_service.dart';
import 'package:med_rent/features/main_layout/home/presentation/widgets/custom_container_tips.dart';
import 'package:med_rent/features/main_layout/home/presentation/widgets/custom_hospital_location.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      "${appLocalizations.hi}, Shrouk",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.waving_hand_sharp,
                      textDirection: TextDirection.ltr,
                      color: Colors.amber.withValues(alpha: 0.5),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Iconsax.notification4,
                        color: Theme.of(context).primaryColor,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  appLocalizations.how_can_we_help_you_today,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 14.sp),
                ),
                SizedBox(height: 16.h),
                CustomSearchTextField(
                  hintText: appLocalizations.search_for_hospitals_or_equipment,
                  iconPrefix: Iconsax.search_normal4,
                  onChanged: (value) {},
                ),
                SizedBox(height: 16.h),
                CustomHospitalLocation(
                  bgImage: ImageAssets.hospitalImage,
                  title: appLocalizations.yourLocation,
                  subTitle: appLocalizations
                      .enable_location_to_find_hospitals_near_you,
                  textButton: appLocalizations.enableLocation,
                  icon: Iconsax.location5,
                  onPressedButton: () {},
                ),
                SizedBox(height: 16.h),
                Text(
                  appLocalizations.try_ourServices,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                CustomContainerService(
                  title: appLocalizations.hospitalSearch,
                  subTitle: appLocalizations
                      .find_hospitals_by_specialty_location_and_rating,
                  icon: Iconsax.search_normal,
                  textButton: appLocalizations.searchNow,
                  onPressedButton: () {},
                ),
                CustomContainerService(
                  title: appLocalizations.equipmentRental,
                  subTitle: appLocalizations
                      .rent_or_purchase_medical_devices_and_equipment,
                  icon: Iconsax.box,
                  textButton: appLocalizations.browseNow,
                  onPressedButton: () {},
                ),
                CustomContainerService(
                  title: appLocalizations.aIAssistant,
                  subTitle: appLocalizations
                      .find_hospitals_by_specialty_location_and_rating,
                  icon: Iconsax.message,
                  textButton: appLocalizations.startChat,
                  onPressedButton: () {},
                ),
                Text(
                  appLocalizations.tips_for_better_health,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(height: 10.h),
                Row(
                  spacing: 10.w,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomContainerTips(
                        iconImage: IconAssets.iconSalad,
                        title: appLocalizations.balancedMeals,
                        subtitle: appLocalizations
                            .include_proteins_vegetables_fruits_and_whole_grains_in_every_meal,
                      ),
                    ),
                    Expanded(
                      child: CustomContainerTips(
                        iconImage: IconAssets.iconWater,
                        title: appLocalizations.stayHydrated,
                        isColorBlue: false,
                        subtitle: appLocalizations
                            .drink_at_least_8_glasses_of_water_a_day_to_keep_your_body_and_skin_healthy,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 7.w,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomContainerTips(
                        iconImage: IconAssets.iconSnooze,
                        title: appLocalizations.getEnoughSleep,
                        isColorBlue: false,
                        subtitle: appLocalizations
                            .try_to_sleep_7_8_hours_per_night_to_improve_your_focus_and_overall_health,
                      ),
                    ),
                    Expanded(
                      child: CustomContainerTips(
                        iconImage: IconAssets.iconRunning,
                        title: appLocalizations.exerciseRegularly,
                        subtitle: appLocalizations
                            .aim_for_at_least_30_minutes_for_physical_activity_daily_to_stay_fit,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
