import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/admin_add_doctor/presentation/widgets/card_add_image.dart';
import 'package:med_rent/features/admin_add_doctor/presentation/widgets/custom_add_text_form_field.dart';
import 'package:med_rent/features/update_profile/presentation/widgets/personal_profile_gender_text.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class AdminAddDoctor extends StatefulWidget {
  const AdminAddDoctor({super.key});

  @override
  State<AdminAddDoctor> createState() => _AdminAddDoctorState();
}

class _AdminAddDoctorState extends State<AdminAddDoctor> {
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController experienceYearController;
  late TextEditingController emailController;
  late TextEditingController specializationController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    experienceYearController = TextEditingController();
    emailController = TextEditingController();
    specializationController = TextEditingController();
    startTimeController = TextEditingController();
    endTimeController = TextEditingController();
    priceController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    experienceYearController.dispose();
    emailController.dispose();
    specializationController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(appLocalizations.addDoctor),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: REdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardAddImage(
                text: appLocalizations.doctorImage,
                onTap: _showBottomSheetImage,
              ),
              SizedBox(height: 20.h),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                color: ColorManager.white,
                elevation: 5,
                child: Padding(
                  padding: REdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        appLocalizations.doctorInformation,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(fontSize: 16.sp),
                      ),
                      SizedBox(height: 20.h),
                      CustomAddTextFormField(
                        controller: nameController,
                        hintText: appLocalizations.enter_name_of_doctor,
                        keyboardType: TextInputType.text,
                        labelName: appLocalizations.name,
                      ),
                      SizedBox(height: 12.h),
                      CustomAddTextFormField(
                        controller: emailController,
                        hintText: appLocalizations.enter_email,
                        keyboardType: TextInputType.emailAddress,
                        labelName: appLocalizations.email,
                      ),
                      SizedBox(height: 12.h),
                      CustomAddTextFormField(
                        controller: passwordController,
                        hintText: appLocalizations.enter_password,
                        keyboardType: TextInputType.text,
                        labelName: appLocalizations.password,
                      ),
                      SizedBox(height: 12.h),
                      CustomAddTextFormField(
                        controller: experienceYearController,
                        hintText: appLocalizations.enter_experience_year,
                        keyboardType: TextInputType.number,
                        labelName: appLocalizations.experienceYear,
                      ),
                      SizedBox(height: 12.h),
                      CustomAddTextFormField(
                        controller: specializationController,
                        hintText: appLocalizations.enter_specialization,
                        keyboardType: TextInputType.text,
                        labelName: appLocalizations.specialization,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        appLocalizations.hospital,
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium!.copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 8.h),
                      PersonalProfileGenderText(
                        isGender: false,
                        selectedLabel: "Tanta University Hospital",
                        menuItems: [
                          "Tanta University Hospital",
                          "Cairo University Hospital",
                        ],
                        onChange: (value) {},
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        appLocalizations.department,
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium!.copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 8.h),
                      PersonalProfileGenderText(
                        isGender: false,
                        selectedLabel: "Oncology",
                        menuItems: [
                          "Oncology",
                          "Cairo University Hospital",
                        ],
                        onChange: (value) {},
                      ),
                      SizedBox(height: 12.h),
                      CustomAddTextFormField(
                        controller: priceController,
                        hintText: appLocalizations.enter_price_of_consutation,
                        keyboardType: TextInputType.number,
                        labelName: appLocalizations.price,
                      ),
                      SizedBox(height: 12.h),
                      CustomAddTextFormField(
                        controller: startTimeController,
                        hintText: appLocalizations.enter_start_time,
                        keyboardType: TextInputType.number,
                        labelName: appLocalizations.startTime,
                      ),
                      SizedBox(height: 12.h),
                      CustomAddTextFormField(
                        controller: endTimeController,
                        hintText: appLocalizations.enter_end_time,
                        keyboardType: TextInputType.number,
                        labelName: appLocalizations.end_Time,
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(appLocalizations.addDoctor),
                    SizedBox(width: 10.w),
                    Icon(Icons.arrow_upward),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheetImage() {
    final appLocalizations = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => Padding(
        padding: REdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(Icons.photo_camera_outlined),
                  SizedBox(width: 10.w),
                  Text(appLocalizations.take_a_photo),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(Icons.photo_library_outlined),
                  SizedBox(width: 10.w),
                  Text(appLocalizations.choose_from_gallery),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
