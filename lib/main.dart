import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:nutri_plant/screens/login_screen.dart';
import 'package:nutri_plant/screens/register_screen.dart';
import 'package:nutri_plant/screens/sign_up_login_screen.dart';
import 'package:nutri_plant/screens/splash_screen.dart';
import 'package:nutri_plant/screens/welcome_screen.dart';
import 'package:nutri_plant/screens/onboarding_screen.dart';

import 'const.dart';

void main() {
  Gemini.init(
    apiKey: GEMINI_API_KEY,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(), // Starting screen
      debugShowCheckedModeBanner: false,
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/sign_up_login': (context) => SignUpLoginScreen(),
        '/register': (context) => RegistrationScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}


