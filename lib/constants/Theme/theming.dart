import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vista/constants/consts.dart';

class CustomTheme {
  Color lightPrimaryColor = HexColor('#19bc99');
  Color darkPrimaryColor = HexColor('#1f9b71');

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light()
        .copyWith(primary: _CustomTheme.lightPrimaryColor),
    // - - - - -Light Theme Elevated Button Styles - - - - -
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          const Size(double.infinity, 55),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) => _CustomTheme.lightPrimaryColor),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
          (_) {
            return RoundedRectangleBorder(borderRadius: kBorderRadius);
          },
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (states) =>
              const TextStyle(fontWeight: FontWeight.normal, fontSize: 23),
        ),
        foregroundColor:
            MaterialStateProperty.all<Color>(Colors.white), //actual text color
      ),
    ),
    // - - - - - - - - - - - - - - -  - - - - -
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark()
        .copyWith(primary: _CustomTheme.darkPrimaryColor),

    // - - - - -Dark Theme Elevated Button Styles - - - - -
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          const Size(double.infinity, 55),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) => _CustomTheme.lightPrimaryColor),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
          (_) {
            return RoundedRectangleBorder(borderRadius: kBorderRadius);
          },
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (states) =>
              const TextStyle(fontWeight: FontWeight.normal, fontSize: 23),
        ),
        foregroundColor:
            MaterialStateProperty.all<Color>(Colors.white), //actual text color
      ),
    ),
    // - - - - - - - - - - - - - - -  - - - - -
  );
}

CustomTheme _CustomTheme = CustomTheme();
