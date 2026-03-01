import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/main_layout/hospital/data/models/hospital_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalDetailsHeader extends StatelessWidget {
  const HospitalDetailsHeader({
    super.key,
    required this.model,
  });

  final HospitalModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
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
        SizedBox(height: 14.h),
        Row(
          children: [
            Expanded(
              child: Text(
                model.name,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Icon(Iconsax.star1, color: ColorManager.yellow, size: 30),
                SizedBox(width: 5.w),
                Text(
                  model.average.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Icon(Iconsax.location, color: ColorManager.greyText),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                model.address,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.h),
        Row(
          children: [
            Icon(Icons.phone_rounded, color: ColorManager.greyText),
            SizedBox(width: 10.w),
            Text(
              "(123) 456-7890",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        SizedBox(height: 14.h),
        Row(
          children: [
            Icon(
              Icons.subdirectory_arrow_left_outlined,
              color: ColorManager.greyText,
            ),
            SizedBox(width: 10.w),
            Text(
              "Get Directions",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        SizedBox(height: 14.h),
        Row(
          children: [
            Icon(Icons.language_outlined, color: ColorManager.greyText),
            SizedBox(width: 10.w),
            Expanded(
              child: InkWell(
                onTap: ()=> _openDirection(model.direction),
                child: Text(
                  model.direction ?? "",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  Future<void> _openDirection(String? url) async {
    if (url == null || url.isEmpty) return;

    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

}
