import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class ThemeManager {
  static ThemeData lightTheme = ThemeData(
    primaryColor: ColorManager.darkBlue,
    useMaterial3: false,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorManager.background,

    colorScheme: const ColorScheme.light(
      primary: ColorManager.darkBlue,
      onPrimary: ColorManager.white,
      secondary: ColorManager.secondary,
      onSecondary: ColorManager.black,
      background: ColorManager.background,
      onBackground: ColorManager.black,
      surface: ColorManager.white,
      onSurface: ColorManager.black,
      error: ColorManager.error,
      onError: ColorManager.white,
    ),

    /// TEXT THEME
    textTheme: TextTheme(
      displayLarge: GoogleFonts.inter(
        color: ColorManager.black,
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.inter(
        color: ColorManager.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: GoogleFonts.inter(
        color: ColorManager.darkBlue,
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: GoogleFonts.inter(
        color: ColorManager.black,
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: ColorManager.secondary,
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
      ),
      bodyMedium: GoogleFonts.inter(
        color: ColorManager.greyText,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: GoogleFonts.inter(
        color: ColorManager.greyText,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: GoogleFonts.inter(
        color: ColorManager.black,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: GoogleFonts.inter(
        color: ColorManager.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.inter(
        color: ColorManager.black,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
      ),
      titleLarge:  GoogleFonts.inter(
        color: ColorManager.secondary,
        fontWeight: FontWeight.bold,
        fontSize: 24.sp,
      ),
      titleMedium: GoogleFonts.inter(
        color: ColorManager.black,
        fontWeight: FontWeight.bold,
        fontSize: 20.sp,
      ),
    ),

    /// APPBAR
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.background,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(
        color: ColorManager.darkBlue,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: ColorManager.black),
    ),

    /// BUTTON TYPES
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.darkBlue,
        foregroundColor: ColorManager.white,
        padding: REdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorManager.darkBlue,
        padding: REdgeInsets.symmetric(horizontal: 20, vertical: 14),
        side: BorderSide(color: ColorManager.darkBlue, width: 1.4.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    ),

    /// TEXT FORM FIELD DECORATION
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.lightBlue,
      contentPadding: REdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: ColorManager.secondary, width: 2.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: ColorManager.error),
      ),
      hintStyle: GoogleFonts.inter(color: ColorManager.greyText),
      labelStyle: GoogleFonts.inter(color: ColorManager.greyText),
    ),

    /// CARD THEME
    cardTheme: CardThemeData(
      color: ColorManager.white,
      margin: REdgeInsets.all(8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: ColorManager.lightBlue, width: 1.w),
      ),
    ),

    /// BOTTOM NAVIGATION
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      selectedItemColor: ColorManager.darkBlue,
      unselectedItemColor: ColorManager.greyText,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
    ),
  );
}
