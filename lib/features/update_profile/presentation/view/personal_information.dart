import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/main_layout/profile/presentation/widgets/user_image_profile.dart';
import 'package:med_rent/features/update_profile/presentation/widgets/custom_profile_text_form_field.dart';
import 'package:med_rent/features/update_profile/presentation/widgets/personal_profile_gender_text.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  late TextEditingController nameController;

  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
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
        title: Text(appLocalizations.personalInformation),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: UserImageProfile(
                  widgetUserImageProfile: CircleAvatar(
                    radius: 40.r,
                    child: Icon(Icons.person, size: 40.sp),
                  ),
                  onTapCamera: _showBottomSheetImage,
                ),
              ),
              SizedBox(height: 16.h),
              CustomProfileTextFormField(
                controller: TextEditingController(text: "Ahmed L."),
                hintText: appLocalizations.enterYourName,
                keyboardType: TextInputType.name,
                labelName: appLocalizations.name,
              ),
              SizedBox(height: 16.h),
              CustomProfileTextFormField(
                labelName: appLocalizations.date_ofBirth,
                controller: TextEditingController(text: "1 / 12 / 1960"),
                hintText: "enter date brith",
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h),
              Text(
                appLocalizations.gender,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: ColorManager.darkBlue),
              ),
              SizedBox(height: 8.h),
              PersonalProfileGenderText(
                selectedLabel: appLocalizations.male,
                menuItems: [appLocalizations.male, appLocalizations.female],
                onChange: (value) {},
              ),
              // CustomProfileTextFormField(
              //   controller: TextEditingController(text: "male"),
              //   hintText: "enter your gender",
              //   keyboardType: TextInputType.name,
              //   isDownArrow: true,
              // ),
              SizedBox(height: 16.h),
              CustomProfileTextFormField(
                labelName: appLocalizations.phone,

                controller: TextEditingController(text: "+20-109-966-959-7"),
                hintText: "enter your number",
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16.h),
              CustomProfileTextFormField(
                labelName: appLocalizations.email,

                controller: TextEditingController(
                  text: "marwawageeh75@gmail.com",
                ),
                hintText: "enter your email",
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 29.h),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(appLocalizations.saveChanges),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheetImage() {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => Padding(
        padding: REdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Icon(Icons.photo_camera_outlined),
                  SizedBox(width: 10.w),
                  Text(
                    appLocalizations.take_a_photo,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Icon(Icons.photo_library_outlined),
                  SizedBox(width: 10.w),
                  Text(
                    appLocalizations.choose_from_gallery,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
