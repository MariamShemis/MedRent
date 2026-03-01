import 'package:flutter/widgets.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class StringsKeys {
  static String connectionTimedOut(BuildContext context) =>
      AppLocalizations.of(context)!.connectionTimedOut;

  static String requestCancelled(BuildContext context) =>
      AppLocalizations.of(context)!.requestCancelled;

  static String noInternetConnection(BuildContext context) =>
      AppLocalizations.of(context)!.noInternetConnection;

  static String unexpectedError(BuildContext context) =>
      AppLocalizations.of(context)!.unexpectedError;

  static String somethingWentWrong(BuildContext context) =>
      AppLocalizations.of(context)!.somethingWentWrong;

  static String serverError(BuildContext context) =>
      AppLocalizations.of(context)!.serverError;

  static String serviceUnavailable(BuildContext context) =>
      AppLocalizations.of(context)!.serviceUnavailable;

  static String invalidEmailOrPassword(BuildContext context) =>
      AppLocalizations.of(context)!.invalidEmailOrPassword;

  static String badRequest(BuildContext context) =>
      AppLocalizations.of(context)!.badRequest;

  static String unauthorized(BuildContext context) =>
      AppLocalizations.of(context)!.unauthorized;

  static String forbidden(BuildContext context) =>
      AppLocalizations.of(context)!.forbidden;

  static String resourceNotFound(BuildContext context) =>
      AppLocalizations.of(context)!.resourceNotFound;

  static String conflict(BuildContext context) =>
      AppLocalizations.of(context)!.conflict;

  static String emailAlreadyExists(BuildContext context) =>
      AppLocalizations.of(context)!.emailAlreadyExists;


}
