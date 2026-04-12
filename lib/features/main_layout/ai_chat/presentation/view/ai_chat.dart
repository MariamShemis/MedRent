import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/core/widgets/custom_search_text_field.dart';
import 'package:med_rent/features/main_layout/ai_chat/data/cubit/chat_ai_cubit.dart';
import 'package:med_rent/features/main_layout/ai_chat/data/models/chat_response_model.dart';
import 'package:med_rent/features/main_layout/ai_chat/presentation/widgets/custom_card_ai_chat.dart';
import 'package:med_rent/features/main_layout/ai_chat/presentation/widgets/custom_card_ai_nearby_hospital.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class AiChat extends StatefulWidget {
  const AiChat({super.key});

  @override
  State<AiChat> createState() => _AiChatState();
}

class _AiChatState extends State<AiChat> {
  final TextEditingController symptomsController = TextEditingController();

  @override
  void dispose() {
    symptomsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(appLocalizations.aI_MedicalAssistant) , leading: SizedBox(),),
        body: BlocConsumer<ChatAiCubit, ChatAiState>(
          listener: (context, state) {
            if (state is ChatAiError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            ChatResponseModel? latestResponse;

            if (state is ChatAiSuccess && state.messages.isNotEmpty) {
              final lastAiMsg = state.messages.lastWhere(
                (m) => !m.isUser,
                orElse: () => ChatMessage(isUser: true, text: ''),
              );
              latestResponse = lastAiMsg.fullResponse;
            } else if (state is ChatAiError) {
              latestResponse = null;
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations
                          .describe_your_symptoms_and_let_our_smart_assistant_guide_you_to_the_right_department_or_nearby_hospitals,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      appLocalizations.describeYourSymptoms,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
                    ),
                    SizedBox(height: 8.h),
                    CustomSearchTextField(
                      controller: symptomsController,
                      hintText: appLocalizations
                          .e_g_I_have_a_sharp_headache_and_feel_dizzy,
                      maxLines: 5,
                      isDarkColor: true,
                    ),
                    SizedBox(height: 16.h),

                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: state is ChatAiLoading
                            ? null
                            : () {
                                if (symptomsController.text
                                    .trim()
                                    .isNotEmpty) {
                                  context.read<ChatAiCubit>().sendMessage(
                                    symptomsController.text.trim(),
                                  );
                                  FocusScope.of(context).unfocus();
                                }
                              },
                        child: state is ChatAiLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.h,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(appLocalizations.analyzeSymptoms),
                      ),
                    ),
                    if (state is ChatAiError) ...[
                      SizedBox(height: 7.h),
                      Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    state.error,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<ChatAiCubit>().sendMessage(
                                  symptomsController.text.trim(),
                                );
                              },
                              child: Text(
                                "please try again now",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (latestResponse != null) ...[
                      SizedBox(height: 7.h),
                      Center(
                        child: Text(
                          appLocalizations.your_input_is_processed_securely,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontSize: 12.sp, color: Colors.grey),
                        ),
                      ),

                      CustomCardAiChat(
                        color: ColorManager.lightBlue,
                        title: latestResponse.department,
                        isWidget: true,
                        widget: Text(
                          appLocalizations
                              .based_on_your_symptoms_this_department_is_the_most_relevant_for_a_consultation,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      CustomCardAiChat(
                        color: ColorManager.lightBlue,
                        title: appLocalizations.suggestedActions,
                        isWidget: false,
                        subTitles: latestResponse.suggestedActions,
                      ),
                      CustomCardAiChat(
                        color: ColorManager.lightBlue,
                        title: appLocalizations.howtoUse,
                        isWidget: false,
                        subTitles: [latestResponse.howToUse],
                      ),
                      if (latestResponse.hospitals.isNotEmpty)
                        CustomCardAiChat(
                          color: ColorManager.white,
                          title: appLocalizations.nearbyHospitals,
                          isWidget: true,
                          widget: Column(
                            children: latestResponse.hospitals
                                .map(
                                  (h) => Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: CustomCardAiNearbyHospital(
                                      title: h.name,
                                      subTitle:
                                          "${h.distance} ${appLocalizations.miles_away}  | ",
                                      rating: h.rating,
                                      textElevatedButton:
                                          appLocalizations.viewDetails,
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.hospitalDetails,
                                          arguments: h.hospitalId,
                                        );
                                      },
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                    ],
                    SizedBox(height: 20.h),
                    Text(
                      appLocalizations
                          .this_tool_provides_general_guidance_and_does_not_replace_professional_medical_diagnosis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(fontSize: 10.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
