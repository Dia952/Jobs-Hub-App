import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobs_hub/Views/Login-Register/login_screen.dart';
import 'package:jobs_hub/shared/styles/colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: primaryColor,
          primarySwatch: primarySwatchColor,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: primaryColor,
            elevation: 0.0,
            titleTextStyle: TextStyle(color: Colors.white),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: primaryColor,
              statusBarBrightness: Brightness.light,
            ),
          )),
      // home: const ProfileScreen(),
      home: const Scaffold(
        body: Center(
          child: LoginScreen(),
        ),
      ),
    );
  }
}
