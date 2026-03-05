import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:med_rent/features/contact_us/data/cubit/contact_us_cubit.dart';
import 'package:med_rent/features/contact_us/data/cubit/contact_us_state.dart';
import 'package:med_rent/features/contact_us/presentation/widgets/contact_information_contact_us.dart';
import 'package:med_rent/features/contact_us/presentation/widgets/select_location_map.dart';
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
      body: BlocConsumer<ContactUsCubit, ContactUsState>(
        listener: (context, state) {
          if (state is ContactUsSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );

            _nameController.clear();
            _emailController.clear();
            _subjectController.clear();
            _messageController.clear();
          }

          if (state is ContactUsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
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
                SelectLocationMap(
                  onLocationSelected: (latLng) {
                    print("Lat: ${latLng.latitude}");
                    print("Lng: ${latLng.longitude}");
                  },
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: state is ContactUsLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: () {
                      context.read<ContactUsCubit>().sendContactMessage(
                        name: _nameController.text,
                        email: _emailController.text,
                        subject: _subjectController.text,
                        body: _messageController.text,
                      );
                    },
                    child: Text(appLocalizations.sendMessage),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  },
),
    );
  }
}
