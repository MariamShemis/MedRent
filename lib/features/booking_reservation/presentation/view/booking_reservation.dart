import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/widgets/custom_search_text_field.dart';
import 'package:med_rent/features/booking_reservation/data/cubit/booking_reservation_cubit.dart';
import 'package:med_rent/features/booking_reservation/data/cubit/booking_reservation_state.dart';
import 'package:med_rent/features/booking_reservation/data/models/reservation_details_model.dart';
import 'package:med_rent/features/booking_reservation/presentation/widgets/reservation_card.dart';
import 'package:med_rent/features/booking_reservation/presentation/widgets/reservation_details_dialog.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class BookingReservation extends StatefulWidget {
  final String role;

  const BookingReservation({super.key, required this.role});

  @override
  State<BookingReservation> createState() => _BookingReservationState();
}

class _BookingReservationState extends State<BookingReservation> {
  String selectedFilter = 'All';

  List<String> getFiltersForRole(String role) {
    if (role == 'Admin') {
      return [
        'All',
        'Booked',
        'PendingPayment',
        'Pending',
        'Completed',
        'Confirmed',
        'PickupRequested',
      ];
    }
    if (role == 'Doctor') return ['All', 'Pending', 'Confirmed', 'Completed'];
    return ['All', 'Booked', 'PendingPayment', 'PickupRequested'];
  }

  @override
  void initState() {
    super.initState();
    context.read<BookingReservationCubit>().fetchBookings(role: widget.role);
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    bool isAdmin = widget.role == 'Admin';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(appLocalizations.reservation),
      ),
      body: BlocListener<BookingReservationCubit, BookingReservationState>(
        listener: (context, state) {
          if (state is BookingDetailsLoaded) {
            _openDetailsDialog(context, state.details, widget.role);
          } else if (state is BookingReservationError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: REdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomSearchTextField(
                hintText: isAdmin
                    ? appLocalizations.search_by_Name
                    : appLocalizations.search_by_Name_or_phone,
                iconPrefix: Iconsax.search_normal4,
                onChanged: (value) => context
                    .read<BookingReservationCubit>()
                    .fetchBookings(role: widget.role, search: value),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 45.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: getFiltersForRole(widget.role).length,
                  separatorBuilder: (c, i) => SizedBox(width: 10.w),
                  itemBuilder: (c, i) {
                    final filter = getFiltersForRole(widget.role)[i];
                    return _buildFilterButton(filter);
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child:
                    BlocBuilder<
                      BookingReservationCubit,
                      BookingReservationState
                    >(
                      builder: (context, state) {
                        if (state is BookingReservationLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final bookings = context
                            .read<BookingReservationCubit>()
                            .currentBookings;
                        if (bookings.isEmpty) {
                          return const Center(child: Text("No Data Found"));
                        }
                        return ListView.separated(
                          itemCount: bookings.length,
                          separatorBuilder: (c, i) => SizedBox(height: 16.h),
                          itemBuilder: (c, i) {
                            final b = bookings[i];
                            return ReservationCard(
                              patientName: b.customerName,
                              isAdmin: isAdmin,
                              bookingStatus: b.status,
                              status: b.type ?? "",
                              itemName: b.itemName ?? "",
                              phone: b.phone,
                              date: b.date.split('T')[0],
                              time: b.time,
                              amount: b.amount ?? 0,
                              onDisplayTap: () {
                                context
                                    .read<BookingReservationCubit>()
                                    .getBookingDetails(b.id, widget.role);
                              },
                            );
                          },
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(String title) {
    bool isSelected = selectedFilter == title;
    return GestureDetector(
      onTap: () {
        setState(() => selectedFilter = title);
        context.read<BookingReservationCubit>().fetchBookings(
          role: widget.role,
          status: title == 'All' ? null : title,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: BoxBorder.all(
            color: isSelected ? ColorManager.secondary : Colors.transparent,
          ),
          color: isSelected
              ? ColorManager.secondary.withOpacity(0.1)
              : ColorManager.lightBlue,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16.sp , color: isSelected
              ? ColorManager.secondary
              : ColorManager.greyText,),
        ),
      ),
    );
  }

  void _openDetailsDialog(
      BuildContext context,
      ReservationDetailsModel details,
      String role,
      ) {
    showDialog(
      context: context,
      builder: (context) => ReservationDetailsDialog(
        details: details,
        role: role,
      ),
    );
  }
}
