import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vista/constants/Theme/theming.dart';
import 'package:vista/features/auth/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token = "";
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

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
