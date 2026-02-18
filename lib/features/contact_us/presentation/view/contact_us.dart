import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/features/contact_us/presentation/widgets/contact_information_contact_us.dart';
import 'package:med_rent/features/update_profile/presentation/widgets/custom_profile_text_form_field.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  late TextEditingController _emailController;

  late TextEditingController _nameController;

  late TextEditingController _subjectController;

  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _subjectController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
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
        title: Text(appLocalizations.contactUs),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: SingleChildScrollView(
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                Center(
                  child: Text(
                    appLocalizations.we_re_here_to_help_Send_us_a_message_or_find_our_contact_information_below,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                  ),
                ),
                SizedBox(height: 14.h),
                Center(
                  child: Text(
                    appLocalizations.send_us_a_message,
                    style: Theme.of(
                      context,
                    ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
                  ),
                ),
                SizedBox(height: 14.h),
                CustomProfileTextFormField(
                  controller: _nameController,
                  isLightBlue: true,
                  hintText: appLocalizations.enter_Your_full_name,
                  keyboardType: TextInputType.name,
                  labelName: appLocalizations.name,
                ),
                SizedBox(height: 16.h),
                CustomProfileTextFormField(
                  controller: _emailController,
                  isLightBlue: true,
                  hintText: appLocalizations.enterYourEmail,
                  keyboardType: TextInputType.emailAddress,
                  labelName: appLocalizations.email,
                ),
                SizedBox(height: 16.h),
                CustomProfileTextFormField(
                  controller: _subjectController,
                  isLightBlue: true,
                  hintText: "",
                  keyboardType: TextInputType.text,
                  labelName: appLocalizations.subject,
                ),
                SizedBox(height: 16.h),
                CustomProfileTextFormField(
                  controller: _messageController,
                  isLightBlue: true,
                  maxLine: 5,
                  hintText: "",
                  keyboardType: TextInputType.text,
                  labelName: appLocalizations.message,
                ),
                SizedBox(height: 16.h),
                Center(
                  child: Text(
                    appLocalizations.contactInformation,
                    style: Theme.of(
                      context,
                    ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
                  ),
                ),
                SizedBox(height: 16.h),
                ContactInformationContactUs(
                  location:
                      "RXGW+8M3، سبرباي، طنطا،, Tanta, Gharbia Governorate, Egypt",
                  phoneNumber: '+201286878176',
                  email: 'marwawageeh75@gmail.com',
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(appLocalizations.sendMessage),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
