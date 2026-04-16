import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/core/widgets/custom_search_text_field.dart';
import 'package:med_rent/features/admin_doctor/data/models/admin_doctor_model.dart';
import 'package:med_rent/features/admin_doctor/presentation/widgets/admin_doctor_card.dart';
import 'package:med_rent/features/admin_doctor/presentation/widgets/card_add_doctor.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class AdminDoctor extends StatelessWidget {
  const AdminDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(appLocalizations.doctor),
      ),
      body: Padding(
        padding: REdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CardAddDoctor(onTap: () {
                Navigator.pushNamed(context, AppRoutes.adminAddDoctor);
              }, text: appLocalizations.addDoctor),
            ),
            SizedBox(height: 16.h),
            CustomSearchTextField(
              hintText: appLocalizations.search_by_Name,
              iconPrefix: Iconsax.search_normal4,
              onChanged: (value) {},
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: GridView.builder(
                padding: REdgeInsets.only(top: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 0.56,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return AdminDoctorCard(
                    model: AdminDoctorModel(
                      doctorId: 11,
                      name: 'Dr. Ahmed Murad',
                      specialization: 'Surgery',
                      experienceYears: 11,
                      rating: 4.5,
                      startTime: '09:00:00',
                      endTime: '17:00:00',
                      consultationPrice: 200,
                      imageURL: '',
                      department: 'Oncology',
                      hospital: 'Tanta University Educational Hospital',
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
