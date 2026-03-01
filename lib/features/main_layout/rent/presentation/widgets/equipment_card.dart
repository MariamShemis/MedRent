import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/features/equipment%20details/data/models/rating_summary.dart';
import 'package:med_rent/features/main_layout/rent/data/models/equipment_model.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class EquipmentCard extends StatelessWidget {
  final EquipmentModel equipment;
  final RatingSummaryModel? ratingSummary;

  const EquipmentCard({super.key, required this.equipment, this.ratingSummary});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final average = ratingSummary?.average ?? equipment.rating;
    final count = ratingSummary?.count ?? equipment.reviewsCount;
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(8.72.r),
        border: Border.all(color: const Color(0xFFC0C0C0), width: 0.55.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8.72.r),
                ),
                child: Image.network(
                  equipment.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.broken_image, size: 50.sp, color: Colors.grey),
                ),
              ),
            ),
          ),

          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ColorManager.lightBlue.withOpacity(0.6),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(8.72.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    equipment.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Row(
                    children: [
                      Wrap(
                        spacing: 1.w,
                        children: List.generate(
                          5,
                              (index) => Icon(
                                Iconsax.star1,
                                size: 12.sp,
                            color: index < average.floor()
                                ? Colors.amber
                                : Colors.grey.shade400,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "($count ${count == 1 ? "${appLocalizations.review}" : "${appLocalizations.reviews}"})",
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${appLocalizations.from} \$${equipment.pricePerDay.toInt()}/${appLocalizations.day}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 28.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.equipmentDetails,
                          arguments: equipment.equipmentId,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.darkBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        appLocalizations.viewDetails,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
