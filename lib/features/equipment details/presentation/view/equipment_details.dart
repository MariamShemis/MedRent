import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/equipment%20details/data/cubit/equipment_details_cubit.dart';
import 'package:med_rent/features/equipment%20details/data/data_sources/equipment_details_data_source.dart';
import 'package:med_rent/features/equipment%20details/presentation/widgets/custom_card_item_details.dart';
import 'package:med_rent/features/equipment%20details/presentation/widgets/custom_description_specification.dart';
import 'package:med_rent/features/equipment%20details/presentation/widgets/custom_item_price_details.dart';
import 'package:med_rent/features/equipment%20details/presentation/widgets/equipment_details_calender.dart';
import 'package:med_rent/features/equipment%20details/presentation/widgets/user_review.dart';
import 'package:med_rent/features/rent_payment/presentation/view/rent_payment.dart';
import 'package:med_rent/l10n/app_localizations.dart';

import '../../data/cubit/equipment_details_state.dart';

class EquipmentDetails extends StatefulWidget {
  final int equipmentId;

  const EquipmentDetails({super.key, required this.equipmentId});

  @override
  State<EquipmentDetails> createState() => _EquipmentDetailsState();
}

class _EquipmentDetailsState extends State<EquipmentDetails> {
  late PageController _pageController;
  DateTime focusedDay = DateTime.now();
  List<DateTime> selectedDays = [];
  bool _isCalendarInitialized = false;
  bool _isSelectionModeActive = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    focusedDay = DateTime.now();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _initializeCalendar(EquipmentDetailsLoaded state) {
    if (mounted && !_isCalendarInitialized) {
      setState(() {
        final bookedDates = state.availability.bookedDates;
        if (bookedDates.isNotEmpty) {
          bookedDates.sort();
          focusedDay = bookedDates.first;
        }
        _isCalendarInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(appLocalizations.productDetails),
      ),
      body: BlocProvider<EquipmentDetailsCubit>(
        create: (context) => EquipmentDetailsCubit(
          dataSource: EquipmentDetailsDataSource(),
          context: context,
        ),
        child: BlocBuilder<EquipmentDetailsCubit, EquipmentDetailsState>(
          builder: (context, state) {
            if (state is EquipmentDetailsInitial) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<EquipmentDetailsCubit>().fetchEquipmentDetails(
                  widget.equipmentId,
                );
              });
            }

            if (state is EquipmentDetailsLoading) {
              return Center(
                child: CircularProgressIndicator(color: ColorManager.darkBlue),
              );
            }

            if (state is EquipmentDetailsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 50.sp, color: Colors.red),
                    SizedBox(height: 16.h),
                    Text(state.message, style: TextStyle(fontSize: 16.sp)),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<EquipmentDetailsCubit>()
                            .refreshEquipmentDetails(widget.equipmentId);
                      },
                      child: Text('Retry', style: TextStyle(fontSize: 14.sp)),
                    ),
                  ],
                ),
              );
            }

            if (state is EquipmentDetailsLoaded) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _initializeCalendar(state);
              });
              final equipment = state.equipment;
              final reviews = state.reviews;
              final ratingSummary = state.ratingSummary;
              final availability = state.availability;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCardItemDetails(image: equipment.imageUrl),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            equipment.name,
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Icon(
                                    Iconsax.star1,
                                    size: 22.sp,
                                    color: index < ratingSummary.average.floor()
                                        ? Colors.amber
                                        : Colors.grey.shade300,
                                  ),
                                ),
                              ),
                              Text(
                                "(${ratingSummary.count} ${appLocalizations.reviews})",
                                style: Theme.of(context).textTheme.bodySmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            appLocalizations.rentalPricing,
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomItemPriceDetails(
                                  isColorDark: false,
                                  textPer: appLocalizations.perDay,
                                  textPrice:
                                      "${equipment.pricePerDay} ${appLocalizations.lE}",
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: CustomItemPriceDetails(
                                  isColorDark: true,
                                  textPer: appLocalizations.perWeek,
                                  textPrice:
                                      "${(equipment.pricePerDay * 7 * (1 - _calculateSmartDiscount(equipment.pricePerDay) / 100)).toStringAsFixed(2)} ${appLocalizations.lE}",
                                  textSavePrice:
                                      "${appLocalizations.save} ${_calculateSmartDiscount(equipment.pricePerDay).toStringAsFixed(0)}%",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          Center(
                            child: Text(
                              appLocalizations.specification,
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(fontWeight: FontWeight.w800),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          CustomDescriptionSpecification(
                            text1: equipment.description,
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            appLocalizations.checkAvailability,
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            padding: EdgeInsets.all(16.r),
                            decoration: BoxDecoration(
                              color: ColorManager.lightBlue,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: EquipmentCalendar(
                              bookedDates: availability.bookedDates,
                              selectedDays: selectedDays,
                              isSelectionModeActive: _isSelectionModeActive,
                              onSelectionChanged: (newDays) {
                                setState(() {
                                  selectedDays = newDays;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            appLocalizations.userReviews,
                            style: Theme.of(context).textTheme.headlineLarge!
                                .copyWith(fontSize: 18.sp),
                          ),
                          SizedBox(height: 16.h),
                          UserReview(
                            rating: ratingSummary.average.toStringAsFixed(1),
                            ratingReview:
                                "${appLocalizations.based_on} ${ratingSummary.count} ${appLocalizations.reviews}",
                            reviews: reviews,
                            ratingSummary: ratingSummary,
                          ),
                          SizedBox(height: 24.h),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.darkBlue,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              onPressed: () {
                                // if (selectedDays.isNotEmpty && _isSelectionModeActive) {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(
                                //       content: Text('You selected ${selectedDays.length} days for rental'),
                                //       backgroundColor: Colors.green,
                                //     ),
                                //   );
                                // } else {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(
                                //       content: Text('Please select dates first'),
                                //       backgroundColor: Colors.orange,
                                //     ),
                                //   );
                                // }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(appLocalizations.rentNow),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 32.h),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  double _calculateSmartDiscount(double dailyPrice) {
    double maxDiscount = 25.0;
    double minDiscount = 10.0;
    double maxPrice = 500.0;
    double discount =
        maxDiscount - ((dailyPrice / maxPrice) * (maxDiscount - minDiscount));

    return discount.clamp(minDiscount, maxDiscount);
  }
}
