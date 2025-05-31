import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nutri_plant/screens/authentication_screens/finger_auth_screen.dart';
import 'package:nutri_plant/screens/authentication_screens/login_screen.dart';
import 'package:nutri_plant/screens/authentication_screens/verifyEmail.dart';
import 'package:nutri_plant/screens/onboarding_screen.dart';
import 'package:nutri_plant/screens/authentication_screens/register_screen.dart';
import 'package:nutri_plant/screens/authentication_screens/sign_up_login_screen.dart';
import 'package:nutri_plant/screens/welcome_screen.dart';
import 'package:nutri_plant/screens/home_screen.dart'; // Import your HomeScreen
import 'package:nutri_plant/wrapper.dart'; // Import wrapper.dart
import 'const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Gemini.init(apiKey: GEMINI_API_KEY);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Wrapper(),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/sign_up_login': (context) => SignUpLoginScreen(),
        '/register': (context) => RegistrationScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(), // Add HomeScreen route
        '/verifyEmail': (context) => VerifyEmailScreen(),
      },
    );
  }
}

