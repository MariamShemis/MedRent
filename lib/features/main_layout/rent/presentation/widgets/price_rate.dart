import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class PriceRate extends StatefulWidget {
  const PriceRate({super.key});

  @override
  State<PriceRate> createState() => _PriceRateState();
}

class _PriceRateState extends State<PriceRate> {
  double currentPrice = 100;
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.lightBlue,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 16.w),

          trailing: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ColorManager.darkBlue,
          ),
          title: Text(
            appLocalizations.dailyRentalRate,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 16.sp,
              color: ColorManager.darkBlue,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 4,
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 8.r,
                      ),
                      overlayShape: RoundSliderOverlayShape(
                        overlayRadius: 16.r,
                      ),
                    ),
                    child: Slider(
                      value: currentPrice,
                      min: 0,
                      max: 1000,
                      divisions: 49,
                      activeColor: ColorManager.darkBlue,
                      inactiveColor: Colors.grey.shade300,
                      onChanged: (double newValue) {
                        setState(() {
                          currentPrice = newValue;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "\$10",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Color(0Xff676767),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "\$${currentPrice.toInt()}${currentPrice >= 500 ? '+' : ''}",
                        style: Theme.of(context).textTheme.labelMedium!
                            .copyWith(
                              color: ColorManager.darkBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                      ),

                      Text(
                        "\$500+",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Color(0Xff676767),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
