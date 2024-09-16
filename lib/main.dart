import 'package:flutter/material.dart';
import 'package:nutri_plant/screens/login_screen.dart';
// import 'package:nutri_plant/screens/onboarding_screen_two.dart';
import 'package:nutri_plant/screens/register_screen.dart';
import 'package:nutri_plant/screens/sign_up_login_screen.dart';
import 'package:nutri_plant/screens/splash_screen.dart';
import 'package:nutri_plant/screens/welcome_screen.dart';
import 'package:nutri_plant/screens/onboarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        // '/onboarding_two': (context) => OnboardingScreenTwo(),
        '/sign_up_login': (context) => SignUpLoginScreen(),
        '/register': (context) => RegistrationScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
