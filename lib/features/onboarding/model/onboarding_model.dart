import 'package:flutter/cupertino.dart';
import 'package:med_rent/core/constants/assets_manager.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class OnboardingModel {
  final String name;
  final String image;
  final String description;

  OnboardingModel({
    required this.name,
    required this.image,
    required this.description,
  });

  static List<OnboardingModel> getOnboarding(BuildContext context){
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return [
      OnboardingModel(
        name: appLocalizations.bookTheNearestHospitalEasily,
        image: ImageAssets.onboarding1,
        description:
        appLocalizations.locateYourAreaAndFindTheBestAndNearestHospitalsInAFewSimpleSteps,
      ),
      OnboardingModel(
        name: appLocalizations.rentMedicalEquipmentAnytime,
        image: ImageAssets.onboarding2,
        description:
        appLocalizations.chooseTheRightDeviceSeeTheDetailsAndBookItImmediatelyWithDeliveryToYourDoorstep,
      ),
      OnboardingModel(
        name: appLocalizations.smartAssistantForYourSymptoms,
        image: ImageAssets.onboarding3,
        description:
        appLocalizations.enterYourSymptomsAndTheSmartAssistantWillGuideYouToTheAppropriateSectionForYourCondition,
      ),

    ];
  }

}
