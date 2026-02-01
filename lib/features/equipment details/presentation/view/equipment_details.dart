import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/equipment%20details/presentation/widgets/custom_card_item_details.dart';
import 'package:med_rent/features/equipment%20details/presentation/widgets/custom_description_specification.dart';
import 'package:med_rent/features/equipment%20details/presentation/widgets/custom_item_price_details.dart';
import 'package:med_rent/features/equipment%20details/presentation/widgets/user_review.dart';
import 'package:med_rent/l10n/app_localizations.dart';
import 'package:table_calendar/table_calendar.dart';

class EquipmentDetails extends StatefulWidget {
  const EquipmentDetails({super.key});

  @override
  State<EquipmentDetails> createState() => _EquipmentDetailsState();
}

class _EquipmentDetailsState extends State<EquipmentDetails> {
  late PageController _pageController;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  final List<DateTime> occupiedDays = [
    DateTime(2025, 11, 18),
    DateTime(2025, 11, 19),
    DateTime(2025, 11, 20),
    DateTime(2025, 11, 21),
    DateTime(2025, 11, 22),
    DateTime(2025, 11, 23),
  ];

  @override
  void initState() {
    super.initState();
    focusedDay = occupiedDays.first;
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(appLocalizations.productDetails),
      ),
      body: Padding(
        padding: REdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCardItemDetails(
                image:
                    "https://images.pexels.com/photos/35842222/pexels-photo-35842222.jpeg",
              ),
              SizedBox(height: 16.h),
              Text(
                "Electric wheelchair",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20.sp),
                      Icon(Icons.star, color: Colors.amber, size: 20.sp),
                      Icon(Icons.star, color: Colors.amber, size: 20.sp),
                      Icon(Icons.star, color: Colors.amber, size: 20.sp),
                      Icon(Icons.star_border, color: Colors.grey, size: 20.sp),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "(120 ${appLocalizations.reviews})",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                appLocalizations.rentalPricing,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomItemPriceDetails(
                      isColorDark: false,
                      textPer: appLocalizations.perDay,
                      textPrice: "100.00 LE",
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: CustomItemPriceDetails(
                      isColorDark: true,
                      textPer: appLocalizations.perWeek,
                      textPrice: "700.00 LE",
                      textSavePrice: "Save 15%",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Center(
                child: Text(
                  appLocalizations.specification,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              CustomDescriptionSpecification(
                text1: "Motor Power: 250–300W dual-motor",
                text2: "Battery Range: 15–25 km per full charge",
                text3: "Max Speed: 6 km/h",
                text4: "Climbing Ability: Up to 10–12° incline",
              ),
              SizedBox(height: 25.h),
              Text(
                appLocalizations.checkAvailability,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge!.copyWith(fontSize: 18.sp),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: ColorManager.lightBlue,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: _buildCalendar(),
              ),
              SizedBox(height: 16.h),
              Text(
                appLocalizations.userReviews,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge!.copyWith(fontSize: 18.sp),
              ),
              SizedBox(height: 16.h),
              UserReview(
                rating: "4.5",
                ratingReview: "Based on 120 reviews",
                listRatingStar: List.generate(
                  5,
                  (index) => Icon(
                    index < 4 ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 16.sp,
                  ),
                ),
                ratingBar: Column(
                  children: [
                    _ratingBar(5, 0.6),
                    SizedBox(height: 5.h,),
                    _ratingBar(4, 0.24),
                    SizedBox(height: 5.h,),
                    _ratingBar(3, 0.10),
                    SizedBox(height: 5.h,),
                    _ratingBar(2, 0.04),
                    SizedBox(height: 5.h,),
                    _ratingBar(1, 0.02),
                  ],
                ),
                userTitle1: "Ahmed L.",
                userTitle2: "ALi A.",
                userDescription1:
                    "Comfortable and easy-to-control electric wheelchair with great performance, though the battery life could be slightly better.",
                userDescription2:
                    "Good electric wheelchair with decent comfort and control, but the battery and build quality could be improved.",
                userStarRating1: [
                  Icon(Icons.star, color: Colors.amber, size: 16.sp),
                  Icon(Icons.star, color: Colors.amber, size: 16.sp),
                  Icon(Icons.star, color: Colors.amber, size: 16.sp),
                  Icon(Icons.star, color: Colors.amber, size: 16.sp),
                  Icon(Icons.star_border, color: Colors.grey, size: 16.sp),
                ],
                userStarRating2: [
                  Icon(Icons.star, color: Colors.amber, size: 16.sp),
                  Icon(Icons.star, color: Colors.amber, size: 16.sp),
                  Icon(Icons.star, color: Colors.amber, size: 16.sp),
                  Icon(Icons.star, color: Colors.amber, size: 16.sp),
                  Icon(Icons.star_border, color: Colors.grey, size: 16.sp),
                ],
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month),
                      SizedBox(width: 10.w),
                      Text("Rent Now"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            children: [
              Row(
                children: [
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () => _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                    icon: Icon(
                      Icons.chevron_left,
                      size: 24.sp,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "${_getMonthName(focusedDay.month)} ${focusedDay.year}",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () => _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                    icon: Icon(
                      Icons.chevron_right,
                      size: 24.sp,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _buildLegendItem(ColorManager.green, "Available"),
              SizedBox(width: 8.w),
              _buildLegendItem(ColorManager.lightRed, "occupied"),
              SizedBox(width: 8.w),
              _buildLegendItem(ColorManager.lightGrey, "Selected"),
            ],
          ),
        ),
        TableCalendar(
          onCalendarCreated: (controller) => _pageController = controller,
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: focusedDay,
          calendarFormat: CalendarFormat.month,
          startingDayOfWeek: StartingDayOfWeek.monday,
          headerVisible: false,
          rowHeight: 45.h,
          onPageChanged: (focused) {
            setState(() {
              focusedDay = focused;
            });
          },
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            weekendStyle: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          selectedDayPredicate: (day) => isSameDay(selectedDay, day),
          onDaySelected: (selected, focused) {
            setState(() {
              selectedDay = selected;
              focusedDay = focused;
            });
          },
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) => _dayCell(day),
            selectedBuilder: (context, day, focusedDay) =>
                _dayCell(day, isSelected: true),
            todayBuilder: (context, day, focusedDay) =>
                _dayCell(day, isToday: true),
            outsideBuilder: (context, day, focusedDay) =>
                _dayCell(day, isOutside: true),
          ),
        ),
      ],
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
          width: 10.r,
          height: 10.r,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 4.w),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 9.sp,
            fontWeight: FontWeight.bold,
          ),
          // TextStyle(
          //   fontSize: 9.sp,
          //   color: Colors.black54,
          //   fontWeight: FontWeight.w600,
          // ),
        ),
      ],
    );
  }

  Widget _dayCell(
    DateTime day, {
    bool isSelected = false,
    bool isToday = false,
    bool isOutside = false,
  }) {
    bool isOccupied = occupiedDays.any((d) => isSameDay(d, day));

    Color bgColor;
    Color textColor;

    if (isSelected) {
      bgColor = ColorManager.lightGrey;
      textColor = Colors.black;
    } else if (isOccupied) {
      bgColor = ColorManager.lightRed;
      textColor = Colors.black;
    } else if (isOutside) {
      bgColor = Colors.transparent;
      textColor = Colors.grey.withOpacity(0.5);
    } else {
      bgColor = Colors.transparent;
      textColor = Colors.black;
    }

    return Container(
      margin: EdgeInsets.all(5.r),
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        day.day.toString(),
        style: GoogleFonts.inter(
          fontSize: 13.sp,
          fontWeight: FontWeight.w800,
          color: textColor,
        ),
      ),
    );
  }

  Widget _ratingBar(int star, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(star.toString(), style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 13.sp)),
        SizedBox(width: 8.w),
        Expanded(
          child: LinearProgressIndicator(
            borderRadius: BorderRadius.circular(16.r),
            value: value,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation(ColorManager.darkBlue),
            minHeight: 10.h,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          "${(value * 100).toInt()}%",
          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 13.sp),
        ),
      ],
    );
  }
}
