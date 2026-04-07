import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class BirthDateField extends StatefulWidget {
  final TextEditingController controller;
  const BirthDateField({super.key, required this.controller});

  @override
  State<BirthDateField> createState() => _BirthDateFieldState();
}

class _BirthDateFieldState extends State<BirthDateField> {
  String _previousText = "";

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.date_ofBirth,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: ColorManager.darkBlue),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w900,
            color: ColorManager.greyText,
          ),
          controller: widget.controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "YYYY-MM-DD",
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w900,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(
                color: ColorManager.greyText,
                width: 1.2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(
                color: ColorManager.greyText,
                width: 1.2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(
                color: ColorManager.greyText,
                width: 1.2,
              ),
            ),
          ),
          onChanged: (value) {
            String newText = value.replaceAll('-', '');
            if (newText.length > 8) newText = newText.substring(0, 8);

            String formatted = "";
            for (int i = 0; i < newText.length; i++) {
              formatted += newText[i];
              if (i == 3 || i == 5) formatted += "-";
            }

            if (formatted != widget.controller.text) {
              widget.controller.value = TextEditingValue(
                text: formatted,
                selection: TextSelection.collapsed(offset: formatted.length),
              );
            }
          },
        ),
      ],
    );
  }
}