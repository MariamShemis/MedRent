import 'package:flutter/widgets.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class AppValidators {
  AppValidators._();

  static String? validateEmail(BuildContext context, String? val) {
    final t = AppLocalizations.of(context)!;
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (val == null || val.trim().isEmpty) {
      return t.this_field_is_required;
    } else if (!emailRegex.hasMatch(val)) {
      return t.enter_valid_email;
    }
    return null;
  }
  static String?  validatePassword(BuildContext context ,  String? val){
    final t = AppLocalizations.of(context)!;
    RegExp regExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (val == null || val.isEmpty) {
      return t.this_field_is_required;
    }
    if(!regExp.hasMatch(val)){
      return t.strong_password_please;
    }
    return null;

  }

  static String? validateConfirmPassword(BuildContext context, String? val, String? password) {
    final t = AppLocalizations.of(context)!;
    if (val == null || val.isEmpty) {
      return t.this_field_is_required;
    } else if (val != password) {
      return t.passwords_dont_match;
    }
    return null;
  }

  static String? validateUsername(BuildContext context, String? val) {
    final t = AppLocalizations.of(context)!;
    RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9,.-]+$');
    if (val == null || val.isEmpty) {
      return t.this_field_is_required;
    } else if (!usernameRegex.hasMatch(val)) {
      return t.enter_valid_username;
    }
    return null;
  }

  static String? validatePhoneNumber(BuildContext context, String? val) {
    final t = AppLocalizations.of(context)!;
    if (val == null || val.trim().isEmpty) {
      return t.this_field_is_required;
    }
    String trimmed = val.trim();
    if (trimmed.startsWith('+20')) {
      trimmed = trimmed.substring(3);
    }
    if (int.tryParse(trimmed) == null) {
      return t.enter_numbers_only;
    }
    if (trimmed.length != 10) {
      return t.enter_value_must_be_11_digit_including_country_code_or_10_without_it;
    }
    return null;
  }
}
