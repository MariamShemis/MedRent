import 'package:flutter/material.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class DevicesSearchBar extends StatelessWidget {
  // بنضيف الـ callback دي عشان نبعت النص اللي بيتكتب للـ Screen
  final Function(String)? onChanged;

  const DevicesSearchBar({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged, // هنا بنربط النص اللي بيتكتب بالأكشن
      textAlignVertical: TextAlignVertical.center,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ColorManager.black),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: const Color(0XffEDF5FB),
        hintText: 'Search by name',
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 13,
              color: ColorManager.greyText,
              fontWeight: FontWeight.w500,
            ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          size: 18,
          color: ColorManager.greyText,
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 40),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.greyText, width: 0.5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}