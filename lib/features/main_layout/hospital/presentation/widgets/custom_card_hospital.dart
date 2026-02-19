import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/features/main_layout/hospital/data/models/hospital_model.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class CustomCardHospital extends StatelessWidget {
  const CustomCardHospital({super.key, required this.model});

  final HospitalModel model;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: model.imageUrl != null && model.imageUrl!.isNotEmpty
                ? Image.network(
                    model.imageUrl!,
                    width: double.infinity,
                    height: 200.h,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200.h,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image, size: 50),
                      );
                    },
                  )
                : Container(
                    height: 200.h,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 50),
                  ),
          ),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8.h),
                Text(
                  model.address,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 8.h),
                model.description != null && model.description!.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              model.description!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          Row(
                            spacing: 5.w,
                            children: [
                              Icon(
                                Iconsax.star1,
                                color: ColorManager.yellow,
                                size: 30,
                              ),
                              Text(
                                model.average.toString(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        spacing: 5.w,
                        children: [
                          Icon(
                            Iconsax.star1,
                            color: ColorManager.yellow,
                            size: 30,
                          ),
                          Text(
                            model.average.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(appLocalizations.bookNow),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.hospitalDetails,
                            arguments: model.id,
                          );
                        },
                        child: Text(appLocalizations.viewDetails),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
