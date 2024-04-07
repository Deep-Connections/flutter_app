import 'package:deep_connections/main.dart';
import 'package:flutter/material.dart';

ThemeData theme() {
  const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF95c095),
      onPrimary: Color(0xFFedffed),
      secondary: Color(0xFFfed05c),
      onSecondary: Colors.black,
      tertiary: Color(0xFF947695),
      error: Colors.red,
      onError: Colors.white,
      background: Colors.white,
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black);
  return ThemeData(
    colorScheme: scheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(scheme.primary),
      foregroundColor: MaterialStateProperty.all(scheme.onPrimary),
    )),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(scheme.onPrimary),
    )),
    /*buttonTheme: ButtonThemeData(
      buttonColor: scheme.secondary,
      shape: const ,
    ),*/
    appBarTheme: AppBarTheme(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        iconTheme: IconThemeData(color: scheme.onPrimary),
        surfaceTintColor: Colors.white),
    useMaterial3: true,
  );
}
