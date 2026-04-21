import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class DeliveryAddressSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController streetController;
  final TextEditingController apartmentController;
  final TextEditingController cityController;

  const DeliveryAddressSection({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.streetController,
    required this.apartmentController,
    required this.cityController,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.deliveryAddress,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF031B4E),
          ),
        ),
        SizedBox(height: 16.h),
        _buildLabel(appLocalizations.name),
        _buildTextField(
          context,
          controller: nameController,
          hint: appLocalizations.enter_Your_full_name,
        ),
        SizedBox(height: 12.h),
        _buildLabel(appLocalizations.phone),
        _buildTextField(
          context,
          controller: phoneController,
          hint: appLocalizations.enter_Your_phone_number,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        SizedBox(height: 12.h),
        _buildLabel(appLocalizations.streetAddress),
        _buildTextField(
          context,
          controller: streetController,
          hint: appLocalizations.enter_your_address,
        ),
        SizedBox(height: 12.h),
        _buildLabel(appLocalizations.apartment_Suite_etc_Optional),
        _buildTextField(
          context,
          controller: apartmentController,
          hint: appLocalizations.enter_your_address,
        ),
        SizedBox(height: 12.h),
        _buildLabel(appLocalizations.city),
        _buildTextField(
          context,
          controller: cityController,
          hint: appLocalizations.enter_your_city,
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
