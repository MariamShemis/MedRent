import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcomeTo;

  /// No description provided for @medRent.
  ///
  /// In en, this message translates to:
  /// **'MedRent'**
  String get medRent;

  /// No description provided for @logInToYourExistingAccountOrCreateANewOne.
  ///
  /// In en, this message translates to:
  /// **'Log in to your existing account or create a new one'**
  String get logInToYourExistingAccountOrCreateANewOne;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get welcomeBack;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassword;

  /// No description provided for @forget_password_.
  ///
  /// In en, this message translates to:
  /// **'Forget Password ?'**
  String get forget_password_;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @pleaseEnterYourEmailToReceiveAConfirmationCodeToSetANewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email to receive a confirmation code to set a new password'**
  String get pleaseEnterYourEmailToReceiveAConfirmationCodeToSetANewPassword;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @verification.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verification;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// No description provided for @typeTheVerificationCodeWeHaveSentYou.
  ///
  /// In en, this message translates to:
  /// **'Type the verification code we have sent you'**
  String get typeTheVerificationCodeWeHaveSentYou;

  /// No description provided for @youDidntReceiveAnyCode.
  ///
  /// In en, this message translates to:
  /// **'You didn’t receive any code?'**
  String get youDidntReceiveAnyCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @createNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Create new password'**
  String get createNewPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @pleaseWriteYourNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please write your new password'**
  String get pleaseWriteYourNewPassword;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @bookTheNearestHospitalEasily.
  ///
  /// In en, this message translates to:
  /// **'Book the nearest hospital easily'**
  String get bookTheNearestHospitalEasily;

  /// No description provided for @locateYourAreaAndFindTheBestAndNearestHospitalsInAFewSimpleSteps.
  ///
  /// In en, this message translates to:
  /// **'Locate your area and find the best and nearest hospitals in a few simple steps.'**
  String get locateYourAreaAndFindTheBestAndNearestHospitalsInAFewSimpleSteps;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @rentMedicalEquipmentAnytime.
  ///
  /// In en, this message translates to:
  /// **'Rent Medical Equipment Anytime'**
  String get rentMedicalEquipmentAnytime;

  /// No description provided for @chooseTheRightDeviceSeeTheDetailsAndBookItImmediatelyWithDeliveryToYourDoorstep.
  ///
  /// In en, this message translates to:
  /// **'Choose the right device, see the details, and book it immediately with delivery to your doorstep.'**
  String get chooseTheRightDeviceSeeTheDetailsAndBookItImmediatelyWithDeliveryToYourDoorstep;

  /// No description provided for @smartAssistantForYourSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Smart Assistant for Your Symptoms'**
  String get smartAssistantForYourSymptoms;

  /// No description provided for @enterYourSymptomsAndTheSmartAssistantWillGuideYouToTheAppropriateSectionForYourCondition.
  ///
  /// In en, this message translates to:
  /// **'Enter your symptoms and the smart assistant will guide you to the appropriate section for your condition.'**
  String get enterYourSymptomsAndTheSmartAssistantWillGuideYouToTheAppropriateSectionForYourCondition;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @find.
  ///
  /// In en, this message translates to:
  /// **'Find'**
  String get find;

  /// No description provided for @rent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get rent;

  /// No description provided for @medicalEquipment.
  ///
  /// In en, this message translates to:
  /// **'Medical Equipment'**
  String get medicalEquipment;

  /// No description provided for @searchForEquipmentLikeWheelchair.
  ///
  /// In en, this message translates to:
  /// **'Search for equipment like \'wheelchair\' ..'**
  String get searchForEquipmentLikeWheelchair;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clearAll;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @dailyRentalRate.
  ///
  /// In en, this message translates to:
  /// **'Daily Rental Rate'**
  String get dailyRentalRate;

  /// No description provided for @availability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availability;

  /// No description provided for @showAvailableOnly.
  ///
  /// In en, this message translates to:
  /// **'Show available only'**
  String get showAvailableOnly;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @the_password_has_been_changed.
  ///
  /// In en, this message translates to:
  /// **'View The password has been changed.'**
  String get the_password_has_been_changed;

  /// No description provided for @this_field_is_required.
  ///
  /// In en, this message translates to:
  /// **'this field is required'**
  String get this_field_is_required;

  /// No description provided for @enter_valid_email.
  ///
  /// In en, this message translates to:
  /// **'enter valid email'**
  String get enter_valid_email;

  /// No description provided for @strong_password_please.
  ///
  /// In en, this message translates to:
  /// **'strong password please'**
  String get strong_password_please;

  /// No description provided for @same_password.
  ///
  /// In en, this message translates to:
  /// **'same password'**
  String get same_password;

  /// No description provided for @enter_valid_username.
  ///
  /// In en, this message translates to:
  /// **'enter valid username'**
  String get enter_valid_username;

  /// No description provided for @enter_numbers_only.
  ///
  /// In en, this message translates to:
  /// **'enter numbers only'**
  String get enter_numbers_only;

  /// No description provided for @enter_value_must_be_11_digit_including_country_code_or_10_without_it.
  ///
  /// In en, this message translates to:
  /// **'enter value must be 11 digit including country code or 10 without it'**
  String get enter_value_must_be_11_digit_including_country_code_or_10_without_it;

  /// No description provided for @passwords_dont_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get passwords_dont_match;

  /// No description provided for @hi.
  ///
  /// In en, this message translates to:
  /// **'Hi'**
  String get hi;

  /// No description provided for @how_can_we_help_you_today.
  ///
  /// In en, this message translates to:
  /// **'How can we help you today?'**
  String get how_can_we_help_you_today;

  /// No description provided for @search_for_hospitals_or_equipment.
  ///
  /// In en, this message translates to:
  /// **'Search for hospitals or equipment'**
  String get search_for_hospitals_or_equipment;

  /// No description provided for @enableLocation.
  ///
  /// In en, this message translates to:
  /// **'Enable Location'**
  String get enableLocation;

  /// No description provided for @searchNow.
  ///
  /// In en, this message translates to:
  /// **'Search Now'**
  String get searchNow;

  /// No description provided for @browseNow.
  ///
  /// In en, this message translates to:
  /// **'Browse Now'**
  String get browseNow;

  /// No description provided for @startChat.
  ///
  /// In en, this message translates to:
  /// **'Start Chat'**
  String get startChat;

  /// No description provided for @yourLocation.
  ///
  /// In en, this message translates to:
  /// **'Your Location'**
  String get yourLocation;

  /// No description provided for @enable_location_to_find_hospitals_near_you.
  ///
  /// In en, this message translates to:
  /// **'Enable location to find hospitals near you'**
  String get enable_location_to_find_hospitals_near_you;

  /// No description provided for @try_ourServices.
  ///
  /// In en, this message translates to:
  /// **'Try our Services'**
  String get try_ourServices;

  /// No description provided for @hospitalSearch.
  ///
  /// In en, this message translates to:
  /// **'Hospital Search'**
  String get hospitalSearch;

  /// No description provided for @find_hospitals_by_specialty_location_and_rating.
  ///
  /// In en, this message translates to:
  /// **'Find hospitals by specialty, location, and rating'**
  String get find_hospitals_by_specialty_location_and_rating;

  /// No description provided for @equipmentRental.
  ///
  /// In en, this message translates to:
  /// **'Equipment Rental'**
  String get equipmentRental;

  /// No description provided for @rent_or_purchase_medical_devices_and_equipment.
  ///
  /// In en, this message translates to:
  /// **'Rent or purchase medical devices and equipment'**
  String get rent_or_purchase_medical_devices_and_equipment;

  /// No description provided for @aIAssistant.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get aIAssistant;

  /// No description provided for @tips_for_better_health.
  ///
  /// In en, this message translates to:
  /// **'Tips for better health'**
  String get tips_for_better_health;

  /// No description provided for @balancedMeals.
  ///
  /// In en, this message translates to:
  /// **'Balanced Meals'**
  String get balancedMeals;

  /// No description provided for @stayHydrated.
  ///
  /// In en, this message translates to:
  /// **'Stay Hydrated '**
  String get stayHydrated;

  /// No description provided for @include_proteins_vegetables_fruits_and_whole_grains_in_every_meal.
  ///
  /// In en, this message translates to:
  /// **'Include proteins, vegetables ,fruits, and whole grains in every meal'**
  String get include_proteins_vegetables_fruits_and_whole_grains_in_every_meal;

  /// No description provided for @drink_at_least_8_glasses_of_water_a_day_to_keep_your_body_and_skin_healthy.
  ///
  /// In en, this message translates to:
  /// **'Drink at least 8 glasses of water a day to keep your body and skin healthy'**
  String get drink_at_least_8_glasses_of_water_a_day_to_keep_your_body_and_skin_healthy;

  /// No description provided for @getEnoughSleep.
  ///
  /// In en, this message translates to:
  /// **'Get Enough Sleep'**
  String get getEnoughSleep;

  /// No description provided for @try_to_sleep_7_8_hours_per_night_to_improve_your_focus_and_overall_health.
  ///
  /// In en, this message translates to:
  /// **'Try to sleep 7-8 hours per night to improve your focus, and overall health'**
  String get try_to_sleep_7_8_hours_per_night_to_improve_your_focus_and_overall_health;

  /// No description provided for @exerciseRegularly.
  ///
  /// In en, this message translates to:
  /// **'Exercise Regularly'**
  String get exerciseRegularly;

  /// No description provided for @aim_for_at_least_30_minutes_for_physical_activity_daily_to_stay_fit.
  ///
  /// In en, this message translates to:
  /// **'Aim for at least 30 minutes for physical activity daily to stay fit'**
  String get aim_for_at_least_30_minutes_for_physical_activity_daily_to_stay_fit;

  /// No description provided for @confirmLocation.
  ///
  /// In en, this message translates to:
  /// **'Confirm location'**
  String get confirmLocation;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
