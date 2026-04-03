import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delivery Address",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF031B4E),
          ),
        ),
        SizedBox(height: 16.h),

        _buildLabel("Name"),
        _buildTextField(
          controller: nameController,
          hint: "Enter your full name",
        ),
        SizedBox(height: 12.h),

        _buildLabel("Phone"),
        _buildTextField(
          controller: phoneController,
          hint: "Enter your phone number",
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
        SizedBox(height: 12.h),

        _buildLabel("Street Address"),
        _buildTextField(
          controller: streetController,
          hint: "Enter your address",
        ),
        SizedBox(height: 12.h),

        _buildLabel("Apartment, Suite, etc. (Optional)"),
        _buildTextField(
          controller: apartmentController,
          hint: "Enter your address",
        ),
        SizedBox(height: 12.h),

        _buildLabel("City"),
        _buildTextField(
          controller: cityController,
          hint: "Enter your city",
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey.shade400,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 14.h,
        ),
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
