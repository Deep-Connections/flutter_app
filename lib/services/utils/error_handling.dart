import 'package:flutter/material.dart';

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
}
