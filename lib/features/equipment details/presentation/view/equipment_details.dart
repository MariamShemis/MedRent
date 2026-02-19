import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/equipment%20details/data/cubit/equipment_details_cubit.dart';
import 'package:med_rent/features/equipment%20details/data/data_sources/equipment_details_data_source.dart';
import 'package:med_rent/features/equipment%20details/presentation/widgets/custom_card_item_details.dart';
import 'package:med_rent/features/equipment%20details/presentation/widgets/custom_description_specification.dart';
import 'package:med_rent/features/equipment%20details/presentation/widgets/custom_item_price_details.dart';
import 'package:med_rent/features/equipment%20details/presentation/widgets/user_review.dart';
import 'package:med_rent/features/rent_payment/presentation/view/rent_payment.dart';
import 'package:med_rent/l10n/app_localizations.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../data/cubit/equipment_details_state.dart'
    show
        EquipmentDetailsState,
        EquipmentDetailsInitial,
        EquipmentDetailsLoading,
        EquipmentDetailsError,
        EquipmentDetailsLoaded;

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
        create: (context) =>
            EquipmentDetailsCubit(dataSource: EquipmentDetailsDataSource()),
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
                            child: _buildCalendar(availability.bookedDates),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RentPayment(),
                                  ),
                                );
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

  Widget _buildCalendar(List<DateTime> bookedDates) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Row(
            children: [
              Row(
                children: [
                  IconButton(
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () => _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                    icon: Icon(
                      Icons.chevron_left,
                      size: 20.sp,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "${_getMonthName(focusedDay.month)} ${focusedDay.year}",
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(fontSize: 11.sp),
                  ),
                  IconButton(
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () => _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                    icon: Icon(
                      Icons.chevron_right,
                      size: 20.sp,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Spacer(),
              _buildLegendItem(ColorManager.green, appLocalizations.available),
              SizedBox(width: 4.h),
              _buildLegendItem(
                ColorManager.lightRed,
                appLocalizations.occupied,
              ),
              SizedBox(width: 4.h),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isSelectionModeActive = !_isSelectionModeActive;
                    if (!_isSelectionModeActive) {
                      selectedDays.clear();
                    }
                  });
                },
                child: Row(
                  children: [
                    Container(
                      width: 12.r,
                      height: 12.r,
                      decoration: BoxDecoration(
                        color: _isSelectionModeActive
                            ? ColorManager.secondary.withValues(alpha: 0.8)
                            : ColorManager.greyText,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      appLocalizations.selected,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 9.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        TableCalendar(
          onCalendarCreated: (controller) => _pageController = controller,
          firstDay: DateTime.now().subtract(Duration(days: 365)),
          lastDay: DateTime.now().add(Duration(days: 365)),
          focusedDay: focusedDay,
          calendarFormat: CalendarFormat.month,
          startingDayOfWeek: StartingDayOfWeek.monday,
          headerVisible: false,
          rowHeight: 42.h,
          daysOfWeekHeight: 30.h,
          onPageChanged: (focused) {
            setState(() {
              focusedDay = focused;
            });
          },
          selectedDayPredicate: (day) {
            return selectedDays.any(
              (selectedDay) => isSameDay(selectedDay, day),
            );
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              bool isOccupied = bookedDates.any(
                (d) => isSameDay(d, selectedDay),
              );
              bool isPast = selectedDay.isBefore(
                DateTime.now().subtract(Duration(days: 1)),
              );

              if (_isSelectionModeActive && !isOccupied && !isPast) {
                if (selectedDays.any((d) => isSameDay(d, selectedDay))) {
                  selectedDays.removeWhere((d) => isSameDay(d, selectedDay));
                } else {
                  selectedDays.add(selectedDay);
                }
              } else if (isOccupied) {
                _showOccupiedMessage();
              } else if (isPast) {
                _showPastDateMessage();
              } else if (!_isSelectionModeActive) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Activate "Selected" mode to choose dates'),
                    backgroundColor: Colors.blue,
                  ),
                );
              }
              this.focusedDay = focusedDay;
            });
          },
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) =>
                _dayCell(day, bookedDates),
            selectedBuilder: (context, day, focusedDay) =>
                _dayCell(day, bookedDates, isSelected: true),
            todayBuilder: (context, day, focusedDay) =>
                _dayCell(day, bookedDates, isToday: true),
            outsideBuilder: (context, day, focusedDay) =>
                _dayCell(day, bookedDates, isOutside: true),
          ),
        ),
      ],
    );
  }

  Widget _dayCell(
    DateTime day,
    List<DateTime> bookedDates, {
    bool isSelected = false,
    bool isToday = false,
    bool isOutside = false,
  }) {
    bool isOccupied = bookedDates.any((d) => isSameDay(d, day));
    bool isPast = day.isBefore(DateTime.now().subtract(Duration(days: 1)));
    bool isSelectedDate = selectedDays.any((d) => isSameDay(d, day));

    Color bgColor;
    Color textColor;
    FontWeight fontWeight = FontWeight.normal;

    if (isSelectedDate && _isSelectionModeActive) {
      bgColor = ColorManager.secondary.withValues(alpha: 0.8);
      textColor = Colors.white;
      fontWeight = FontWeight.bold;
    } else if (isOccupied) {
      bgColor = ColorManager.lightRed;
      textColor = ColorManager.black;
      fontWeight = FontWeight.bold;
    } else if (isPast) {
      bgColor = Colors.transparent;
      textColor = Colors.grey.shade400;
    } else if (isOutside) {
      bgColor = Colors.transparent;
      textColor = Colors.grey.shade300;
    } else {
      bgColor = Colors.transparent;
      textColor = Colors.black;
    }

    return Container(
      margin: EdgeInsets.all(7.r),
      padding: EdgeInsets.all(0.r),
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        day.day.toString(),
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: fontWeight,
          color: textColor,
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month - 1];
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12.r,
          height: 12.r,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6.w),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 9.sp,
          ),
        ),
      ],
    );
  }

  void _showOccupiedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('This date is already occupied'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showPastDateMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cannot select past dates'),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 2),
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
