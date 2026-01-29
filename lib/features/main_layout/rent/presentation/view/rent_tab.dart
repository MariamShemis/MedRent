import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/widgets/custom_search_text_field.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class RentTab extends StatelessWidget {
  const RentTab({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(16.0),
          child: Column(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${appLocalizations.find} ',
                      style: TextStyle(color: ColorManager.secondary),
                    ),
                    TextSpan(text: '& '),
                    TextSpan(
                      text: '${appLocalizations.rent} ',
                      style: TextStyle(color: ColorManager.secondary),
                    ),
                    TextSpan(text: appLocalizations.medicalEquipment),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              CustomSearchTextField(
                hintText: appLocalizations.searchForEquipmentLikeWheelchair,
                iconPrefix: Iconsax.search_normal4,
                onChanged: (value) {},
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appLocalizations.filters,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  InkWell(
                    onTap: (){

                    },
                    child: Text(
                      appLocalizations.clearAll,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 16.sp , fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
