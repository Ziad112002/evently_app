import 'package:evently/ui/screens/forgotpass/forgot_password_screen.dart';
import 'package:evently/ui/screens/login/login_screen.dart';
import 'package:evently/ui/screens/navigation/navigation_screen.dart';
import 'package:evently/ui/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';

abstract final class AppRoutes {
  static MaterialPageRoute get signup {
    return MaterialPageRoute(
      builder: (_) {
        return SignupScreen();
      },
    );
  }

  static MaterialPageRoute get login {
    return MaterialPageRoute(
      builder: (_) {
        return LoginScreen();
      },
    );
  }

  static MaterialPageRoute get forgotPassword {
    return MaterialPageRoute(
      builder: (_) {
        return ForgotPasswordScreen();
      },
    );
  }static MaterialPageRoute get navigation {
    return MaterialPageRoute(
      builder: (_) {
        return NavigationScreen();
      },
    );
  }
}
