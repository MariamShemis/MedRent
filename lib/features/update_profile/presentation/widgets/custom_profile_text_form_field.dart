import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class CustomProfileTextFormField extends StatelessWidget {
  const CustomProfileTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isLightBlue = false,
    required this.keyboardType,
    this.validator,
    this.labelName,
    this.maxLine,
    this.onChanged,
    this.suffixIcon,
    this.isLabel = true,
  });

  final TextEditingController controller;
  final String hintText;
  final int? maxLine;
  final String? labelName;
  final bool isLightBlue;
  final bool isLabel;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isLabel
            ? Text(
                labelName ?? "",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: ColorManager.darkBlue),
              )
            : SizedBox(),
        SizedBox(height: isLabel ? 8.h : 0),
        SizedBox(
          width: double.infinity,
          child: TextFormField(
            controller: controller,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: isLightBlue ? FontWeight.w500 : FontWeight.w900,
              color: isLightBlue ? ColorManager.black : ColorManager.greyText,
            ),
            onChanged: onChanged,
            onFieldSubmitted: onChanged,
            cursorColor: Colors.black,
            maxLines: maxLine,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
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
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
