import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/widgets/custom_search_text_field.dart';
import 'package:med_rent/features/booking_reservation_admin/presentation/widgets/reservation_card_admin.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class BookingReservationAdmin extends StatelessWidget {
  const BookingReservationAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(appLocalizations.reservation),
      ),
      body: Padding(
        padding: REdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomSearchTextField(
              hintText: appLocalizations.search_by_Name_or_phone,
              iconPrefix: Iconsax.search_normal4,
              onChanged: (value) {},
            ),
            SizedBox(height: 30.h),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => ReservationCardAdmin(
                  patientName: "Marwa Wageeh",
                  bookingStatus: "Completed",
                  status: "Patient Monitor → Follow Up",
                  phone: "01098180477309",
                  date: "Mon, Oct25, 2026",
                  time: "10:00 AM",
                  onDisplayTap: () {
                    // الكود اللي هيتنفذ لما يضغط على Display
                  },
                ),
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
