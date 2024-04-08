import 'package:flutter/material.dart';

const Set<MaterialState> interactiveStates = <MaterialState>{
  MaterialState.pressed,
  MaterialState.hovered,
  MaterialState.focused,
};

const unselectedColor = Colors.grey;

ThemeData theme() {
  const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF87b080),
      onPrimary: Color(0xFFf5f9f5),
      secondary: Color(0xFFfed05c),
      onSecondary: Color(0xFF281d00),
      tertiary: Color(0xFF947695),
      error: Colors.red,
      onError: Colors.white,
      background: Color(0xFFf5f9f5),
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black);
  return ThemeData(
    colorScheme: scheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
          const TextStyle(inherit: true, fontSize: 17)),
      //, fontWeight: FontWeight.bold
      backgroundColor:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.any(interactiveStates.contains)) {
          return const Color(0xFF81a87b);
        }
        if (states.contains(MaterialState.disabled)) return Colors.grey;
        return scheme.primary;
      }),
      foregroundColor: MaterialStateProperty.all(scheme.onPrimary),
    )),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.any(interactiveStates.contains)) {
          return scheme.onPrimary;
        }
        return scheme.background;
      }),
    )),
    /*buttonTheme: ButtonThemeData(
      buttonColor: scheme.secondary,
      shape: const ,
    ),*/
    appBarTheme: AppBarTheme(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        iconTheme: IconThemeData(color: scheme.onPrimary),
        surfaceTintColor: Colors.white,
        toolbarHeight: 60),
    useMaterial3: true,
  );
}
