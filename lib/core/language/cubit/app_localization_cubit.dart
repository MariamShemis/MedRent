import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/core/language/language_service/language_service.dart';

class AppLocalizationCubit extends Cubit<Locale> {
  AppLocalizationCubit() : super(const Locale('en')) {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    try {
      final savedLanguage = await LanguageService.getSavedLanguage();
      emit(Locale(savedLanguage));
    } catch (e) {
      print('Error loading saved language: $e');
      emit(const Locale('en'));
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    try {
      await LanguageService.saveLanguage(languageCode);
      emit(Locale(languageCode));
    } catch (e) {
      print('Error changing language: $e');
      emit(Locale(languageCode));
    }
  }

  Future<void> toggleLanguage() async {
    final currentLang = state.languageCode;
    if (currentLang == 'en') {
      await changeLanguage('ar');
    } else {
      await changeLanguage('en');
    }
  }

  bool get isArabic => state.languageCode == 'ar';
  bool get isEnglish => state.languageCode == 'en';
}