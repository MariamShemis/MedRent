import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class PatientInfoSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final String selectedBookingType;
  final ValueChanged<String> onBookingTypeChanged;

  const PatientInfoSection({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.selectedBookingType,
    required this.onBookingTypeChanged,
  });

  List<Map<String, String>> getBookingTypes(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context)!;
    return [
      {'key': 'Emergency', 'value': local.emergency},
      {'key': 'Regular', 'value': local.regular},
      {'key': 'Follow-up', 'value': local.followup},
    ];
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final types = getBookingTypes(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.patientInformation,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF031B4E),
          ),
        ),
        SizedBox(height: 16.h),
        _buildLabel(appLocalizations.fullName),
        _buildTextField(
          context,
          controller: nameController,
          hint: appLocalizations.enter_Your_full_name,
        ),
        SizedBox(height: 12.h),
        _buildLabel(appLocalizations.emailAddress),
        _buildTextField(
          context,
          controller: emailController,
          hint: appLocalizations.enter_Your_email,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 12.h),
        _buildLabel(appLocalizations.contactNumber),
        _buildTextField(
          context,
          controller: phoneController,
          hint: appLocalizations.enter_Your_phone_number,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        SizedBox(height: 12.h),
        _buildLabel(appLocalizations.bookingType),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedBookingType,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF020A19),
              ),
              items: types.map((type) {
                return DropdownMenuItem<String>(
                  value: type['key'],
                  child: Text(type['value']!),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  onBookingTypeChanged(value);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF020A19),
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontSize: 14.sp,
        color: ColorManager.black,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14.sp, color: ColorManager.greyText),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xFF031B4E)),
        ),
      ),
    );
  }
}
