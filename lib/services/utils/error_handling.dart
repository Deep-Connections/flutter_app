import 'package:deep_connections/services/utils/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final GlobalKey<ScaffoldMessengerState> globalSnackBarMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MessageHandler {
  static final MessageHandler _instance = MessageHandler._internal();

  factory MessageHandler() {
    return _instance;
  }

  MessageHandler._internal();

  static void showError(String message) {
    final snackBar = SnackBar(content: Text(message));
    globalSnackBarMessengerKey.currentState?.showSnackBar(snackBar);
  }

  static void showResponseError<T>(Response<T> response, AppLocalizations loc) {
    response.onFailure((failureRes) {
      final message = failureRes.getUiErrOrNull(loc);
      if (message != null) {
        showError(message);
      }
    });
  }
}
