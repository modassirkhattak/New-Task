import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/utills/app_colors.dart';
import 'package:test_task/view/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:test_task/view/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Test Task',
      debugShowCheckedModeBanner: false,

      // Optional: Define light theme if needed (won't be used now)
      theme: ThemeData(brightness: Brightness.light),

      // 👉 Set the default dark theme for the entire app
      darkTheme: ThemeData(
        // brightness: Brightness.dark,
        // scaffoldBackgroundColor: primaryBlackColor,
        // primaryColor: primaryBlackColor,
        // appBarTheme: const AppBarTheme(
        //   backgroundColor: Colors.black,
        //   foregroundColor: Colors.white,
        // ),
        // textTheme: const TextTheme(
        //   bodyLarge: TextStyle(color: Colors.white),
        //   bodyMedium: TextStyle(color: Colors.white),
        //   titleLarge: TextStyle(color: Colors.white),
        // ),
        // colorScheme: ColorScheme.dark(
        //   primary: primaryBlackColor,
        //   secondary: Colors.grey,
        // ),
      ),

      // home: StatedPage(),
      home: SplashScreen(),
    );
  }
}
