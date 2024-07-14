import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vista/constants/consts.dart';

class CustomTheme {
  Color lightPrimaryColor = HexColor('#249e41');
  Color darkPrimaryColor = HexColor('#1f9b71');

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light()
        .copyWith(primary: _CustomTheme.lightPrimaryColor),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      showUnselectedLabels: true,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle:
          TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: Colors.grey[200],
      disabledColor: Colors.grey[200],
      selectedColor: Colors.green,
      secondarySelectedColor: Colors.green,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      labelStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      secondaryLabelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      brightness: Brightness.light,
    ),

    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: .9,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: .9,
        ),
      ),
    ),

    dividerTheme: DividerThemeData(
      color: Colors.grey.withOpacity(.7),
      thickness: 1,
      space: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          const Size(double.infinity, 45),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey; 
            }
            return _CustomTheme
                .lightPrimaryColor; 
          },
        ),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
          (_) {
            return RoundedRectangleBorder(borderRadius: kBorderRadius);
          },
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (states) =>
              const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
        ),
        foregroundColor:
            MaterialStateProperty.all<Color>(Colors.white), 
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark()
        .copyWith(primary: _CustomTheme.darkPrimaryColor),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      showUnselectedLabels: true,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle:
          TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
    ),

    listTileTheme: const ListTileThemeData(
      tileColor: Colors.black,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),

    dividerTheme: DividerThemeData(
      color: Colors.grey.withOpacity(.2),
      thickness: 1,
      space: 1,
    ),

    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: .9,
          // color: Colors.grey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: .9,
          // color: Colors.grey,
        ),
      ),
    ),

    // - - - - -Dark Theme Elevated Button Styles - - - - -
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          const Size(double.infinity, 45),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey; // Specify the disabled color here
            }
            return _CustomTheme
                .lightPrimaryColor; // Default color for enabled state
          },
        ),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
          (_) {
            return RoundedRectangleBorder(borderRadius: kBorderRadius);
          },
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (states) =>
              const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
        ),
        foregroundColor:
            MaterialStateProperty.all<Color>(Colors.white), //actual text color
      ),
    ),

    iconTheme: const IconThemeData(color: Colors.white),

  );
}

CustomTheme _CustomTheme = CustomTheme();
 