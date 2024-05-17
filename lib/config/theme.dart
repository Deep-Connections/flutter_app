import 'package:flutter/material.dart';

const Set<MaterialState> interactiveStates = <MaterialState>{
  MaterialState.pressed,
  MaterialState.hovered,
  MaterialState.focused,
};

class DcColors {
  static final Color grey = Colors.grey.shade400;
}

late ButtonStyle cancelElevatedButtonTheme;

ThemeData theme() {
  const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF87b080),
      onPrimary: Color(0xFFf5f9f5),
      secondary: Color(0xFFfed05c),
      onSecondary: Color(0xFF281d00),
      tertiary: Color(0xFF947695),
      surfaceVariant: Color(0xFFc4c9c4),
      // left bubble
      error: Colors.red,
      onError: Colors.white,
      background: Color(0xFFf5f9f5),
      onBackground: Colors.black,
      surface: Color(0xFFe0e5e0),
      // right bubble
      onSurface: Colors.black);

  cancelElevatedButtonTheme = ElevatedButton.styleFrom(
    side: BorderSide(color: Colors.grey.shade700, width: 1),
    foregroundColor: Colors.grey.shade700,
    backgroundColor: Colors.white,
    disabledBackgroundColor: Colors.grey.shade300,
    shadowColor: Colors.grey,
    textStyle: const TextStyle(fontSize: 17),
  );

  // todo add text theme
  const textTheme = TextTheme();
  return ThemeData(
    colorScheme: colorScheme,
    //textTheme: textTheme,
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
        return colorScheme.primary;
      }),
      foregroundColor: MaterialStateProperty.all(colorScheme.onPrimary),
    )),
    textButtonTheme: TextButtonThemeData(style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.any(interactiveStates.contains)) {
          return colorScheme.onPrimary;
        }
        return colorScheme.background;
      }),
    )),
    listTileTheme: ListTileThemeData(
        textColor: colorScheme.onBackground,
        titleTextStyle:
            const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        subtitleTextStyle: const TextStyle(inherit: true, fontSize: 15),
        visualDensity: const VisualDensity(vertical: 4)),
    appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
        surfaceTintColor: Colors.white,
        toolbarHeight: 60),
    bottomAppBarTheme: BottomAppBarTheme(
      color: colorScheme.primary,
      height: 60,
    ),
    useMaterial3: true,
  );
}
