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
  /// **'The password has been changed.'**
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

  /// No description provided for @findHospital.
  ///
  /// In en, this message translates to:
  /// **'Find Hospital'**
  String get findHospital;

  /// No description provided for @search_by_location_or_hospital_name.
  ///
  /// In en, this message translates to:
  /// **'Search by location or hospital name'**
  String get search_by_location_or_hospital_name;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book now'**
  String get bookNow;

  /// No description provided for @hospitalDetails.
  ///
  /// In en, this message translates to:
  /// **'Hospital details'**
  String get hospitalDetails;

  /// No description provided for @departments.
  ///
  /// In en, this message translates to:
  /// **'Departments'**
  String get departments;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @patientReviews.
  ///
  /// In en, this message translates to:
  /// **'Patient Reviews'**
  String get patientReviews;

  /// No description provided for @booking.
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get booking;

  /// No description provided for @scheduleYour_booking.
  ///
  /// In en, this message translates to:
  /// **'Schedule Your booking'**
  String get scheduleYour_booking;

  /// No description provided for @availableDoctors.
  ///
  /// In en, this message translates to:
  /// **'Available Doctors'**
  String get availableDoctors;

  /// No description provided for @bookAppointment.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get bookAppointment;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @appointmentSummary.
  ///
  /// In en, this message translates to:
  /// **'Appointment Summary'**
  String get appointmentSummary;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @consultationFee.
  ///
  /// In en, this message translates to:
  /// **'Consultation Fee'**
  String get consultationFee;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @patientInformation.
  ///
  /// In en, this message translates to:
  /// **'Patient Information'**
  String get patientInformation;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enter_Your_full_name.
  ///
  /// In en, this message translates to:
  /// **'Enter Your full name'**
  String get enter_Your_full_name;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @contactNumber.
  ///
  /// In en, this message translates to:
  /// **'Contact Number'**
  String get contactNumber;

  /// No description provided for @enter_Your_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter Your phone number'**
  String get enter_Your_phone_number;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumber;

  /// No description provided for @expiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDate;

  /// No description provided for @cVV.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cVV;

  /// No description provided for @confirm_Pay.
  ///
  /// In en, this message translates to:
  /// **'Confirm & Pay '**
  String get confirm_Pay;

  /// No description provided for @the_process_was_successful.
  ///
  /// In en, this message translates to:
  /// **'The process was successful.'**
  String get the_process_was_successful;

  /// No description provided for @back_to_home.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get back_to_home;

  /// No description provided for @productDetails.
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get productDetails;

  /// No description provided for @rentalPricing.
  ///
  /// In en, this message translates to:
  /// **'Rental Pricing'**
  String get rentalPricing;

  /// No description provided for @perDay.
  ///
  /// In en, this message translates to:
  /// **'Per Day'**
  String get perDay;

  /// No description provided for @perWeek.
  ///
  /// In en, this message translates to:
  /// **'Per Week'**
  String get perWeek;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @specification.
  ///
  /// In en, this message translates to:
  /// **'Specification'**
  String get specification;

  /// No description provided for @usageNotes.
  ///
  /// In en, this message translates to:
  /// **'Usage Notes'**
  String get usageNotes;

  /// No description provided for @checkAvailability.
  ///
  /// In en, this message translates to:
  /// **'Check Availability'**
  String get checkAvailability;

  /// No description provided for @userReviews.
  ///
  /// In en, this message translates to:
  /// **'User Reviews'**
  String get userReviews;

  /// No description provided for @rentNow.
  ///
  /// In en, this message translates to:
  /// **'Rent Now'**
  String get rentNow;

  /// No description provided for @confirmYourRental.
  ///
  /// In en, this message translates to:
  /// **'Confirm Your Rental'**
  String get confirmYourRental;

  /// No description provided for @rentalSummary.
  ///
  /// In en, this message translates to:
  /// **'Rental Summary'**
  String get rentalSummary;

  /// No description provided for @rentalPeriod.
  ///
  /// In en, this message translates to:
  /// **'Rental Period'**
  String get rentalPeriod;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @rentalFee.
  ///
  /// In en, this message translates to:
  /// **'Rental Fee'**
  String get rentalFee;

  /// No description provided for @insuranceFee.
  ///
  /// In en, this message translates to:
  /// **'Insurance Fee'**
  String get insuranceFee;

  /// No description provided for @taxes_Fee.
  ///
  /// In en, this message translates to:
  /// **'Taxes & Fee'**
  String get taxes_Fee;

  /// No description provided for @totalCost.
  ///
  /// In en, this message translates to:
  /// **'Total Cost'**
  String get totalCost;

  /// No description provided for @saveCardForFutureRentals.
  ///
  /// In en, this message translates to:
  /// **'Save Card For Future Rentals'**
  String get saveCardForFutureRentals;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get deliveryAddress;

  /// No description provided for @streetAddress.
  ///
  /// In en, this message translates to:
  /// **'Street Address'**
  String get streetAddress;

  /// No description provided for @enter_your_address.
  ///
  /// In en, this message translates to:
  /// **'Enter your address'**
  String get enter_your_address;

  /// No description provided for @apartment_Suite_etc_Optional.
  ///
  /// In en, this message translates to:
  /// **'Apartment,Suite, etc.(Optional)'**
  String get apartment_Suite_etc_Optional;

  /// No description provided for @sSL_SecuredPayment.
  ///
  /// In en, this message translates to:
  /// **'SSL Secured Payment'**
  String get sSL_SecuredPayment;

  /// No description provided for @confirmRental.
  ///
  /// In en, this message translates to:
  /// **'Confirm Rental'**
  String get confirmRental;

  /// No description provided for @byClicking_ConfirmRental_You_agree_to_our.
  ///
  /// In en, this message translates to:
  /// **'By Clicking “Confirm Rental”,You agree to our'**
  String get byClicking_ConfirmRental_You_agree_to_our;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms Of Service'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @myRentals.
  ///
  /// In en, this message translates to:
  /// **'My Rentals'**
  String get myRentals;

  /// No description provided for @search_by_equipment_name.
  ///
  /// In en, this message translates to:
  /// **'Search by equipment name'**
  String get search_by_equipment_name;

  /// No description provided for @aI_MedicalAssistant.
  ///
  /// In en, this message translates to:
  /// **'AI Medical Assistant'**
  String get aI_MedicalAssistant;

  /// No description provided for @describe_your_symptoms_and_let_our_smart_assistant_guide_you_to_the_right_department_or_nearby_hospitals.
  ///
  /// In en, this message translates to:
  /// **'Describe your symptoms and let our smart assistant guide you to the right department or nearby hospitals.'**
  String get describe_your_symptoms_and_let_our_smart_assistant_guide_you_to_the_right_department_or_nearby_hospitals;

  /// No description provided for @describeYourSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Describe Your Symptoms'**
  String get describeYourSymptoms;

  /// No description provided for @e_g_I_have_a_sharp_headache_and_feel_dizzy.
  ///
  /// In en, this message translates to:
  /// **'e.g., I have a sharp headache and feel dizzy ...'**
  String get e_g_I_have_a_sharp_headache_and_feel_dizzy;

  /// No description provided for @analyzeSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Analyze Symptoms'**
  String get analyzeSymptoms;

  /// No description provided for @your_input_is_processed_securely.
  ///
  /// In en, this message translates to:
  /// **'Your input is processed securely.'**
  String get your_input_is_processed_securely;

  /// No description provided for @cardiology.
  ///
  /// In en, this message translates to:
  /// **'Cardiology'**
  String get cardiology;

  /// No description provided for @based_on_your_symptoms_this_department_is_the_most_relevant_for_a_consultation.
  ///
  /// In en, this message translates to:
  /// **'Based on your symptoms, this department is the most relevant for a consultation.'**
  String get based_on_your_symptoms_this_department_is_the_most_relevant_for_a_consultation;

  /// No description provided for @suggestedActions.
  ///
  /// In en, this message translates to:
  /// **'Suggested Actions'**
  String get suggestedActions;

  /// No description provided for @seek_medical_attention_within_hours.
  ///
  /// In en, this message translates to:
  /// **'Seek medical attention within 24 hours.'**
  String get seek_medical_attention_within_hours;

  /// No description provided for @monitor_any_changes_in_your_breathing.
  ///
  /// In en, this message translates to:
  /// **'Monitor any changes in your breathing.'**
  String get monitor_any_changes_in_your_breathing;

  /// No description provided for @avoid_heavy_physical_activity.
  ///
  /// In en, this message translates to:
  /// **'Avoid heavy physical activity.'**
  String get avoid_heavy_physical_activity;

  /// No description provided for @howtoUse.
  ///
  /// In en, this message translates to:
  /// **'How to Use'**
  String get howtoUse;

  /// No description provided for @describe_symptoms_in_everyday_language.
  ///
  /// In en, this message translates to:
  /// **'Describe symptoms in everyday language.'**
  String get describe_symptoms_in_everyday_language;

  /// No description provided for @include_duration_severity_or_other_notes.
  ///
  /// In en, this message translates to:
  /// **'Include duration, severity, or other notes.'**
  String get include_duration_severity_or_other_notes;

  /// No description provided for @this_is_a_guidance_tool_not_a_diagnosis.
  ///
  /// In en, this message translates to:
  /// **'This is a guidance tool, not a diagnosis.'**
  String get this_is_a_guidance_tool_not_a_diagnosis;

  /// No description provided for @nearbyHospitals.
  ///
  /// In en, this message translates to:
  /// **'Nearby Hospitals'**
  String get nearbyHospitals;

  /// No description provided for @miles_away.
  ///
  /// In en, this message translates to:
  /// **'miles away'**
  String get miles_away;

  /// No description provided for @this_tool_provides_general_guidance_and_does_not_replace_professional_medical_diagnosis.
  ///
  /// In en, this message translates to:
  /// **'This tool provides general guidance and does not replace professional medical diagnosis.'**
  String get this_tool_provides_general_guidance_and_does_not_replace_professional_medical_diagnosis;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'And'**
  String get and;

  /// No description provided for @oxygen.
  ///
  /// In en, this message translates to:
  /// **'Oxygen'**
  String get oxygen;

  /// No description provided for @wheelchairs.
  ///
  /// In en, this message translates to:
  /// **'Wheelchairs'**
  String get wheelchairs;

  /// No description provided for @hospitalBeds.
  ///
  /// In en, this message translates to:
  /// **'Hospital Beds'**
  String get hospitalBeds;

  /// No description provided for @walkersAndCanes.
  ///
  /// In en, this message translates to:
  /// **'Walkers & Canes'**
  String get walkersAndCanes;

  /// No description provided for @patientLifts.
  ///
  /// In en, this message translates to:
  /// **'Patient Lifts'**
  String get patientLifts;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @occupied.
  ///
  /// In en, this message translates to:
  /// **'Occupied'**
  String get occupied;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'day'**
  String get day;

  /// No description provided for @lE.
  ///
  /// In en, this message translates to:
  /// **'LE'**
  String get lE;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @based_on.
  ///
  /// In en, this message translates to:
  /// **'Based on'**
  String get based_on;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @myBooking.
  ///
  /// In en, this message translates to:
  /// **'My Booking'**
  String get myBooking;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// No description provided for @log_out.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get log_out;

  /// No description provided for @date_ofBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get date_ofBirth;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @choose_which_notifications_you_would_like_to_receive_You_can_update_these_settings_at_any_time.
  ///
  /// In en, this message translates to:
  /// **'Choose which notifications you would like to receive. You can update these settings at any time.'**
  String get choose_which_notifications_you_would_like_to_receive_You_can_update_these_settings_at_any_time;

  /// No description provided for @appointmentReminders.
  ///
  /// In en, this message translates to:
  /// **'Appointment Reminders'**
  String get appointmentReminders;

  /// No description provided for @equipmentRentalAlerts.
  ///
  /// In en, this message translates to:
  /// **'Equipment Rental Alerts'**
  String get equipmentRentalAlerts;

  /// No description provided for @reminders_for_upcoming_visits.
  ///
  /// In en, this message translates to:
  /// **'Reminders for upcoming visits'**
  String get reminders_for_upcoming_visits;

  /// No description provided for @reminders_for_return_dates_and_rental_status.
  ///
  /// In en, this message translates to:
  /// **'Reminders for return dates and rental status'**
  String get reminders_for_return_dates_and_rental_status;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @mark_all_as_read.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get mark_all_as_read;

  /// No description provided for @are_you_sure_you_want_to_log_out.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out'**
  String get are_you_sure_you_want_to_log_out;

  /// No description provided for @patientID.
  ///
  /// In en, this message translates to:
  /// **'Patient ID'**
  String get patientID;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @take_a_photo.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get take_a_photo;

  /// No description provided for @choose_from_gallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get choose_from_gallery;

  /// No description provided for @january.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// No description provided for @february.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// No description provided for @march.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// No description provided for @april.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @june.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get june;

  /// No description provided for @july.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get july;

  /// No description provided for @august.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get august;

  /// No description provided for @september.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get september;

  /// No description provided for @october.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get october;

  /// No description provided for @november.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get november;

  /// No description provided for @december.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get december;

  /// No description provided for @this_date_is_already_occupied.
  ///
  /// In en, this message translates to:
  /// **'This date is already occupied'**
  String get this_date_is_already_occupied;

  /// No description provided for @cannot_select_past_dates.
  ///
  /// In en, this message translates to:
  /// **'Cannot select past dates'**
  String get cannot_select_past_dates;

  /// No description provided for @activate_Selected_mode_to_choose_dates.
  ///
  /// In en, this message translates to:
  /// **'Activate \"Selected\" mode to choose dates'**
  String get activate_Selected_mode_to_choose_dates;

  /// No description provided for @loginSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Login Successfully'**
  String get loginSuccessfully;

  /// No description provided for @connectionTimedOut.
  ///
  /// In en, this message translates to:
  /// **'Connection timed out'**
  String get connectionTimedOut;

  /// No description provided for @requestCancelled.
  ///
  /// In en, this message translates to:
  /// **'Request was cancelled'**
  String get requestCancelled;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error'**
  String get unexpectedError;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error'**
  String get serverError;

  /// No description provided for @serviceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Service unavailable'**
  String get serviceUnavailable;

  /// No description provided for @invalidEmailOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get invalidEmailOrPassword;

  /// No description provided for @badRequest.
  ///
  /// In en, this message translates to:
  /// **'Bad request'**
  String get badRequest;

  /// No description provided for @unauthorized.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized access'**
  String get unauthorized;

  /// No description provided for @forbidden.
  ///
  /// In en, this message translates to:
  /// **'Access forbidden'**
  String get forbidden;

  /// No description provided for @resourceNotFound.
  ///
  /// In en, this message translates to:
  /// **'Resource not found'**
  String get resourceNotFound;

  /// No description provided for @conflict.
  ///
  /// In en, this message translates to:
  /// **'Conflict occurred'**
  String get conflict;

  /// No description provided for @emailAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Email Already Exists'**
  String get emailAlreadyExists;

  /// No description provided for @we_re_here_to_help_Send_us_a_message_or_find_our_contact_information_below.
  ///
  /// In en, this message translates to:
  /// **'We\'re here to help. Send us a message or find our contact information below.'**
  String get we_re_here_to_help_Send_us_a_message_or_find_our_contact_information_below;

  /// No description provided for @send_us_a_message.
  ///
  /// In en, this message translates to:
  /// **'Send us a message'**
  String get send_us_a_message;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @contactInformation.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInformation;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessage;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @choose_your_preferred_language_for_the_app_interface.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language for the app interface'**
  String get choose_your_preferred_language_for_the_app_interface;

  /// No description provided for @enter_the_digit_OTP_sent_to_your_email.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit OTP sent to your email'**
  String get enter_the_digit_OTP_sent_to_your_email;

  /// No description provided for @didnt_get_the_OTP.
  ///
  /// In en, this message translates to:
  /// **'Didn’t get the OTP?'**
  String get didnt_get_the_OTP;

  /// No description provided for @resend_OTP.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resend_OTP;
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
