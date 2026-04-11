import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/widgets/custom_search_text_field.dart';
import 'package:med_rent/features/booking_reservation_doctor/data/cubit/booking_reservation_cubit.dart';
import 'package:med_rent/features/booking_reservation_doctor/data/cubit/booking_reservation_state.dart';
import 'package:med_rent/features/booking_reservation_doctor/data/models/reservation_details_model.dart';
import 'package:med_rent/features/booking_reservation_doctor/presentation/widgets/reservation_card.dart';
import 'package:med_rent/features/booking_reservation_doctor/presentation/widgets/reservation_details_dialog.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class BookingReservation extends StatefulWidget {
  final String role;

  const BookingReservation({super.key, required this.role});

  @override
  State<BookingReservation> createState() => _BookingReservationState();
}

class _BookingReservationState extends State<BookingReservation> {
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
                onChanged: (value) {
                  context.read<BookingReservationCubit>().fetchBookings(
                    role: widget.role,
                    search: value,
                  );
                },
              ),
              SizedBox(height: 30.h),
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

                        if (bookings.isEmpty &&
                            state is! BookingReservationLoading) {
                          return const Center(child: Text("No Data Found"));
                        }

                        return ListView.separated(
                          itemBuilder: (context, index) {
                            final booking = bookings[index];
                            return ReservationCard(
                              patientName: booking.customerName,
                              isAdmin: isAdmin,
                              bookingStatus: booking.status,
                              status: booking.type ?? "",
                              itemName: booking.itemName ?? "",
                              phone: booking.phone,
                              date: booking.date.split('T')[0],
                              time: booking.time,
                              amount: booking.amount ?? 0,
                              onDisplayTap: () {
                                print(
                                  "Clicked ID: ${booking.id} for Role: ${widget.role}",
                                );
                                context
                                    .read<BookingReservationCubit>()
                                    .getBookingDetails(booking.id, widget.role);
                              },
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.h),
                          itemCount: bookings.length,
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

  void _openDetailsDialog(
    BuildContext context,
    ReservationDetailsModel details,
    String role,
  ) {
    showDialog(
      context: context,
      builder: (context) => ReservationDetailsDialog(details: details),
    );
  }
}
