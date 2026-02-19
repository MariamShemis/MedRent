import 'package:flutter/material.dart';

class AppLocalizationState {
  final Locale locale;
  final bool isRTL;

  const AppLocalizationState({
    required this.locale,
    required this.isRTL,
  });

  factory AppLocalizationState.initial() {
    return const AppLocalizationState(
      locale: Locale('en'),
      isRTL: false,
    );
  }

  AppLocalizationState copyWith({
    Locale? locale,
    bool? isRTL,
  }) {
    return AppLocalizationState(
      locale: locale ?? this.locale,
      isRTL: isRTL ?? this.isRTL,
    );
  }
}
