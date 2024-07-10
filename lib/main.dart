import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vista/constants/Theme/theming.dart';
import 'package:vista/features/auth/login/login.dart';

// import 'package:intl/intl_standalone.dart'
//     if (dart.library.html) 'package:intl/intl_browser.dart';

import 'home_pages/home.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await findSystemLocale();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token = "ksksk";
  bool isDarkModeEnabled = false;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(750, 1334),
        builder: (BuildContext context, Widget? child) {
          return GetMaterialApp(
            supportedLocales: const <Locale>[
              Locale('en', ''),
              Locale('ar', ''),
            ],
            routes: {
              '/login': (context) => const LoginPage(),
              '/home': (context) => const HomePage(title: 'Vista'),
            },
            debugShowCheckedModeBanner: false,
            home: token == ""
                ? const LoginPage()
                : const HomePage(title: 'Vista'),
            theme: CustomTheme.lightTheme,
            darkTheme: CustomTheme.darkTheme,
            themeMode: isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
          );
        });
  }
}
