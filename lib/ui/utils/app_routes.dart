import 'package:evently/ui/screens/login/login_screen.dart';
import 'package:evently/ui/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';

abstract final class AppRoutes {
  static MaterialPageRoute get signupScreen {
    return MaterialPageRoute(
      builder: (_) {
        return SignupScreen();
      },
    );
  }

  static MaterialPageRoute get loginScreen {
    return MaterialPageRoute(
      builder: (_) {
        return LoginScreen();
      },
    );
  }
}
