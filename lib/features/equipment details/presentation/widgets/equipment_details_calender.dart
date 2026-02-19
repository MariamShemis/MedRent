import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class EquipmentCalendar extends StatefulWidget {
  final List<DateTime> bookedDates;
  final List<DateTime> selectedDays;
  final bool isSelectionModeActive;
  final Function(List<DateTime>)? onSelectionChanged;

  const EquipmentCalendar({
    super.key,
    required this.bookedDates,
    required this.selectedDays,
    required this.isSelectionModeActive,
    this.onSelectionChanged,
  });

  @override
  State<EquipmentCalendar> createState() => _EquipmentCalendarState();
}

class _EquipmentCalendarState extends State<EquipmentCalendar> {
  late DateTime focusedDay;
  late bool _isSelectionModeActive = false;

  @override
  void initState() {
    super.initState();
    _isSelectionModeActive = widget.isSelectionModeActive;

    if (widget.bookedDates.isNotEmpty) {
      widget.bookedDates.sort();
      focusedDay = widget.bookedDates.first;
    } else {
      focusedDay = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Row(
            children: [
              IconButton(
                constraints: BoxConstraints(),
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    focusedDay = DateTime(focusedDay.year, focusedDay.month - 1, 1);
                  });
                },
                icon: Icon(Icons.chevron_left, size: 20.sp, color: Colors.black54),
              ),
              Text(
                "${_getMonthName(focusedDay.month)} ${focusedDay.year}",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 11.sp),
              ),
              IconButton(
                constraints: BoxConstraints(),
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    focusedDay = DateTime(focusedDay.year, focusedDay.month + 1, 1);
                  });
                },
                icon: Icon(Icons.chevron_right, size: 20.sp, color: Colors.black54),
              ),
              Spacer(),
              _buildLegendItem(ColorManager.green, appLocalizations.available),
              SizedBox(width: 4.w),
              _buildLegendItem(ColorManager.lightRed, appLocalizations.occupied),
              SizedBox(width: 4.w),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isSelectionModeActive = !_isSelectionModeActive;
                    if (!_isSelectionModeActive) widget.selectedDays.clear();
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
          firstDay: DateTime(2020, 1, 1),
          lastDay: DateTime(2030, 12, 31),
          focusedDay: focusedDay,
          calendarFormat: CalendarFormat.month,
          startingDayOfWeek: StartingDayOfWeek.monday,
          headerVisible: false,
          rowHeight: 42.h,
          daysOfWeekHeight: 30.h,
          selectedDayPredicate: (day) {
            return widget.selectedDays.any((selectedDay) => isSameDay(selectedDay, day));
          },
          onPageChanged: (focused) {
            setState(() {
              focusedDay = focused;
            });
          },
          onDaySelected: (selectedDay, newFocusedDay) {
            bool isOccupied = widget.bookedDates.any((d) => isSameDay(d, selectedDay));
            bool isPast = selectedDay.isBefore(DateTime.now().subtract(Duration(days: 1)));

            if (_isSelectionModeActive && !isOccupied && !isPast) {
              setState(() {
                if (widget.selectedDays.any((d) => isSameDay(d, selectedDay))) {
                  widget.selectedDays.removeWhere((d) => isSameDay(d, selectedDay));
                } else {
                  widget.selectedDays.add(selectedDay);
                }
                focusedDay = newFocusedDay;
                if (widget.onSelectionChanged != null) {
                  widget.onSelectionChanged!(widget.selectedDays);
                }
              });
            } else if (isOccupied) {
              _showOccupiedMessage();
            } else if (isPast) {
              _showPastDateMessage();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.activate_Selected_mode_to_choose_dates),
                  backgroundColor: Colors.blue,
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) => _dayCell(day, widget.bookedDates),
            selectedBuilder: (context, day, focusedDay) => _dayCell(day, widget.bookedDates, isSelected: true),
            todayBuilder: (context, day, focusedDay) => _dayCell(day, widget.bookedDates, isToday: true),
            outsideBuilder: (context, day, focusedDay) => _dayCell(day, widget.bookedDates, isOutside: true),
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
    bool isSelectedDate = widget.selectedDays.any((d) => isSameDay(d, day));

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
        style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: fontWeight, color: textColor),
      ),
    );
  }

  String _getMonthName(int month) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    var months = [
      appLocalizations.january,
      appLocalizations.february,
      appLocalizations.march,
      appLocalizations.april,
      appLocalizations.may,
      appLocalizations.june,
      appLocalizations.july,
      appLocalizations.august,
      appLocalizations.september,
      appLocalizations.october,
      appLocalizations.november,
      appLocalizations.december,
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
        content: Text(AppLocalizations.of(context)!.this_date_is_already_occupied),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showPastDateMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.cannot_select_past_dates),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
