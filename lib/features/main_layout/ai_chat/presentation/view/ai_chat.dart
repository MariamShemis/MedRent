import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/widgets/custom_search_text_field.dart';
import 'package:med_rent/features/main_layout/ai_chat/presentation/widgets/custom_card_ai_chat.dart';
import 'package:med_rent/features/main_layout/ai_chat/presentation/widgets/custom_card_ai_nearby_hospital.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class AiChat extends StatelessWidget {
  const AiChat({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    appLocalizations.aI_MedicalAssistant,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  appLocalizations
                      .describe_your_symptoms_and_let_our_smart_assistant_guide_you_to_the_right_department_or_nearby_hospitals,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                Text(
                  appLocalizations.describeYourSymptoms,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 8.h),
                CustomSearchTextField(
                  hintText: appLocalizations
                      .e_g_I_have_a_sharp_headache_and_feel_dizzy,
                  maxLines: 5,
                  isDarkColor: true,
                  onChanged: (value) {},
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(appLocalizations.analyzeSymptoms),
                  ),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Text(
                    appLocalizations.your_input_is_processed_securely,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomCardAiChat(
                  color: ColorManager.lightBlue,
                  title: appLocalizations.cardiology,
                  isWidget: true,
                  widget: Text(
                    appLocalizations
                        .based_on_your_symptoms_this_department_is_the_most_relevant_for_a_consultation,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                  ),
                ),
                CustomCardAiChat(
                  color: ColorManager.lightBlue,
                  title: appLocalizations.suggestedActions,
                  subTitle1:
                      appLocalizations.seek_medical_attention_within_hours,
                  subTitle2:
                      appLocalizations.monitor_any_changes_in_your_breathing,
                  subTitle3: appLocalizations.avoid_heavy_physical_activity,
                  isWidget: false,
                ),
                CustomCardAiChat(
                  color: ColorManager.lightBlue,
                  title: appLocalizations.howtoUse,
                  subTitle1:
                      appLocalizations.describe_symptoms_in_everyday_language,
                  subTitle2:
                      appLocalizations.include_duration_severity_or_other_notes,
                  subTitle3:
                      appLocalizations.this_is_a_guidance_tool_not_a_diagnosis,
                  isWidget: false,
                ),
                CustomCardAiChat(
                  color: ColorManager.white,
                  title: appLocalizations.nearbyHospitals,
                  isWidget: true,
                  widget: Column(
                    children: [
                      CustomCardAiNearbyHospital(
                        title: "City Medical Center",
                        subTitle: "2.5 ${appLocalizations.miles_away}   |  ",
                        rating: 4.8,
                        textElevatedButton: appLocalizations.viewDetails,
                        onPressed: () {},
                      ),
                      SizedBox(height: 8.h,),
                      CustomCardAiNearbyHospital(
                        title: "City Medical Center",
                        subTitle: "2.5 ${appLocalizations.miles_away}    |  ",
                        rating: 4.6,
                        textElevatedButton: appLocalizations.viewDetails,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Text(
                  appLocalizations
                      .this_tool_provides_general_guidance_and_does_not_replace_professional_medical_diagnosis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 12.sp),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
