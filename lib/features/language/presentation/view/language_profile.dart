import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/features/language/data/cubit/app_localization_cubit.dart';
import 'package:med_rent/features/language/presentation/widgets/custom_language_card.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class LanguageProfile extends StatefulWidget {
  const LanguageProfile({super.key});

  @override
  State<LanguageProfile> createState() => _LanguageProfileState();
}

class _LanguageProfileState extends State<LanguageProfile> {
  String? selectedLang;

  @override
  void initState() {
    super.initState();
    final currentLocale =
        context.read<AppLocalizationCubit>().state.languageCode;
    selectedLang = currentLocale;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(appLocalizations.selectLanguage),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(vertical: 18.0, horizontal: 16),
        child: Column(
          children: [
            Text(
              appLocalizations
                  .choose_your_preferred_language_for_the_app_interface,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50.h),

            CustomLanguageCard(
              title: "English",
              subTitle: "Default System Language",
              languageCode: "en",
              selectedLanguage: selectedLang!,
              onChanged: (value) {
                setState(() => selectedLang = value);
              },
            ),

            SizedBox(height: 16.h),

            CustomLanguageCard(
              title: "العربية",
              subTitle: "Arabic",
              languageCode: "ar",
              selectedLanguage: selectedLang!,
              onChanged: (value) {
                setState(() => selectedLang = value);
              },
            ),

            SizedBox(height: 70.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await context
                      .read<AppLocalizationCubit>()
                      .changeLanguage(selectedLang!);

                  Navigator.pop(context);
                },
                child: Text(appLocalizations.saveChanges),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
