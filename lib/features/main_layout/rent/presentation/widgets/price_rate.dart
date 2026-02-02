// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:med_rent/core/constants/color_manager.dart';
// import 'package:med_rent/features/main_layout/rent/data/cubit/equipment_cubit.dart';
// import 'package:med_rent/l10n/app_localizations.dart';

// class PriceRate extends StatefulWidget {
//   const PriceRate({super.key});

//   @override
//   State<PriceRate> createState() => _PriceRateState();
// }

// class _PriceRateState extends State<PriceRate> {
//   double currentPrice = 0;
//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations appLocalizations = AppLocalizations.of(context)!;
//     return Container(
//       margin: EdgeInsets.only(bottom: 12.h),
//       decoration: BoxDecoration(
//         color: ColorManager.lightBlue,
//         borderRadius: BorderRadius.circular(15.r),
//       ),
//       child: Theme(
//         data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//         child: ExpansionTile(
//           tilePadding: EdgeInsets.symmetric(horizontal: 16.w),

//           trailing: Icon(
//             Icons.keyboard_arrow_down_rounded,
//             color: ColorManager.darkBlue,
//           ),
//           title: Text(
//             appLocalizations.dailyRentalRate,
//             style: Theme.of(context).textTheme.titleMedium!.copyWith(
//               fontSize: 16.sp,
//               color: ColorManager.darkBlue,
//             ),
//           ),
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//               child: Column(
//                 children: [
//                   SliderTheme(
//                     data: SliderTheme.of(context).copyWith(
//                       trackHeight: 4,
//                       thumbShape: RoundSliderThumbShape(
//                         enabledThumbRadius: 8.r,
//                       ),
//                       overlayShape: RoundSliderOverlayShape(
//                         overlayRadius: 16.r,
//                       ),
//                     ),
//                     child: Slider(
//                       value: currentPrice,
//                       min: 0,
//                       max: 2000,
//                       divisions: 49,
//                       activeColor: ColorManager.darkBlue,
//                       inactiveColor: Colors.grey.shade300,
//                       onChanged: (value) {
//                         setState(() {
//                           currentPrice = value;
//                           context.read<EquipmentCubit>().filter(
//                             min:value,
//                             max: value,
//                             available: false,
//                           );
//                         });
//                       },
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Text(
//                         "\$10",
//                         style: Theme.of(context).textTheme.labelSmall!.copyWith(
//                           color: Color(0Xff676767),
//                           fontSize: 16,
//                         ),
//                       ),
//                       Text(
//                         "\$${currentPrice.toInt()}${currentPrice >= 500 ? '+' : ''}",
//                         style: Theme.of(context).textTheme.labelMedium!
//                             .copyWith(
//                               color: ColorManager.darkBlue,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                       ),

//                       Text(
//                         "\$500+",
//                         style: Theme.of(context).textTheme.labelSmall!.copyWith(
//                           color: Color(0Xff676767),
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
  

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/main_layout/rent/data/cubit/equipment_cubit.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class PriceRate extends StatefulWidget {
  const PriceRate({super.key});

  @override
  State<PriceRate> createState() => _PriceRateState();
}

class _PriceRateState extends State<PriceRate> {
  RangeValues currentRange = const RangeValues(0, 2000);

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return BlocListener<EquipmentCubit, EquipmentState>(
      listener: (context, state) {
        if (state is EquipmentInitial) {
          setState(() {
            currentRange = const RangeValues(0, 2000);
          });
        }
      },
      child: Container(
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
                    fontWeight: FontWeight.bold,
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
                        rangeThumbShape: RoundRangeSliderThumbShape(
                          enabledThumbRadius: 8.r,
                        ),
                        overlayShape: RoundSliderOverlayShape(
                          overlayRadius: 16.r,
                        ),
                      ),
                      child: RangeSlider(
                        values: currentRange,
                        min: 0,
                        max: 2000,
                        divisions: 20, 
                        activeColor: ColorManager.darkBlue,
                        inactiveColor: Colors.grey.shade300,
                        labels: RangeLabels(
                          '\$${currentRange.start.round()}',
                          '\$${currentRange.end.round()}',
                        ),
                        onChanged: (values) {
                          setState(() {
                            currentRange = values;
                          });
                          context.read<EquipmentCubit>().filter(
                                min: values.start,
                                max: values.end,
                              );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                        Text(
                          "\$${currentRange.start.toInt()}",
                          style: TextStyle(
                            color: Color(0Xff676767),
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "${appLocalizations.selected}: \$${currentRange.start.toInt()} - \$${currentRange.end.toInt()}",
                          style: TextStyle(
                            color: ColorManager.darkBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "\$500",
                          style: TextStyle(
                            color: Color(0Xff676767),
                            fontSize: 14.sp,
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
      ),
    );
  }
}