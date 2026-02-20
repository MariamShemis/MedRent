import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class CustomProfileTextFormField extends StatelessWidget {
  const CustomProfileTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isDownArrow = false,
    this.isLightBlue = false,
    required this.keyboardType,
    this.validator,
    required this.labelName,
    this.maxLine,
  });

  final TextEditingController controller;
  final String hintText;
  final int? maxLine;
  final String labelName;
  final bool isDownArrow;
  final bool isLightBlue;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelName,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: ColorManager.darkBlue),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: double.infinity,
          child: TextFormField(
            controller: controller,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: isLightBlue ? FontWeight.w500 : FontWeight.w900,
              color: isLightBlue ? ColorManager.black : ColorManager.greyText,
            ),
            cursorColor: Colors.black,
            maxLines: maxLine,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              filled: true,
              fillColor: isLightBlue
                  ? ColorManager.lightBlue
                  : ColorManager.white,
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: isLightBlue ? FontWeight.w500 : FontWeight.w900,
              ),
              enabledBorder: isLightBlue
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.r),
                      borderSide: BorderSide(
                        color: ColorManager.lightBlue,
                        width: 1,
                      ),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.r),
                      borderSide: BorderSide(
                        color: ColorManager.greyText,
                        width: 1.2,
                      ),
                    ),
              focusedBorder: isLightBlue
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.r),
                      borderSide: BorderSide(
                        color: ColorManager.lightBlue,
                        width: 1,
                      ),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.r),
                      borderSide: BorderSide(
                        color: ColorManager.greyText,
                        width: 1.2,
                      ),
                    ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.r),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.r),
                borderSide: const BorderSide(
                  color: ColorManager.greyText,
                  width: 2,
                ),
              ),
              suffixIcon: isDownArrow
                  ? IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.keyboard_arrow_down_outlined, size: 35),
                    )
                  : null,
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
