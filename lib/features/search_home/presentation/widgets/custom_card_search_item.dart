import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/features/main_layout/hospital/data/models/hospital_model.dart';
import 'package:med_rent/features/main_layout/rent/data/models/equipment_model.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class CustomCardSearchItem extends StatelessWidget {
  final HospitalModel? hospital;
  final EquipmentModel? equipment;

  const CustomCardSearchItem({super.key, this.hospital, this.equipment});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final image = hospital?.imageUrl ?? equipment?.imageUrl ?? "";
    final title = hospital?.name ?? equipment?.name ?? "";
    final description = hospital?.address ?? equipment?.description ?? "";
    final rating = hospital?.average ?? equipment?.rating ?? 0;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      color: ColorManager.lightBlue,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              color: ColorManager.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: image.isNotEmpty
                  ? Image.network(
                      image,
                      fit: BoxFit.cover,
                      height: 200.h,
                      width: double.infinity,
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
          ),

          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(title, style: Theme.of(context).textTheme.labelLarge),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Iconsax.star1,
                          color: ColorManager.yellow,
                          size: 24,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          rating.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                ElevatedButton(
                  onPressed: () {
                    if (hospital != null) {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.hospitalDetails,
                        arguments: hospital!.id,
                      );
                    }
                    if (equipment != null) {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.equipmentDetails,
                        arguments: equipment!.equipmentId,
                      );
                    }
                  },
                  child: Text(appLocalizations.viewDetails),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
