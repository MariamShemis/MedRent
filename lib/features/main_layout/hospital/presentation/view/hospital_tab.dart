import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/widgets/custom_search_text_field.dart';
import 'package:med_rent/features/main_layout/hospital/presentation/widgets/custom_card_hospital.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class HospitalTab extends StatelessWidget {
  const HospitalTab({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations.findHospital,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.copyWith(fontSize: 22.sp),
              ),
              SizedBox(height: 16.h),
              CustomSearchTextField(
                hintText: appLocalizations.search_by_location_or_hospital_name,
                iconPrefix: Iconsax.search_normal4,
                onChanged: (value) {},
              ),
              SizedBox(height: 20.h),
              CustomCardHospital(
                image: "https://images.pexels.com/photos/35842222/pexels-photo-35842222.jpeg",
                titleLocation: "Tanta University Hospital ",
                subTitleLocation: "Tanta University, Tanta, Gharbia",
                description: "Insurance info not available",
                rating: 4,
                onPressedElevatedButton: () {},
                onPressedOutlinedButton: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
