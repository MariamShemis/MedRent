import 'package:flutter/material.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class LanguageProfile extends StatelessWidget {
  const LanguageProfile({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(appLocalizations.selectLanguage),
      ),
    );
  }
}
