import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class CustomSelectLocation extends StatelessWidget {
  const CustomSelectLocation({super.key, required this.textLocation, required this.onPressed});
  final String textLocation;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Container(
      padding: REdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorManager.background,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Iconsax.location , color: ColorManager.black,),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  textLocation,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(appLocalizations.confirmLocation),
            ),
          ),
        ],
      ),
    );
  }
}
