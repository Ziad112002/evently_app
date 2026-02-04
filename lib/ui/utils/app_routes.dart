import 'package:evently/ui/screens/addevent/add_event_screen.dart';
import 'package:evently/ui/screens/edit%20event/edit_event_screens.dart';
import 'package:evently/ui/screens/event%20details/event_details_screen.dart';
import 'package:evently/ui/screens/forgotpass/forgot_password_screen.dart';
import 'package:evently/ui/screens/login/login_screen.dart';
import 'package:evently/ui/screens/navigation/navigation_screen.dart';
import 'package:evently/ui/screens/signup/signup_screen.dart';
import 'package:evently/ui/screens/splash/onboarding/onboarding_screen.dart';
import 'package:evently/ui/screens/splash/start_screen.dart';
import 'package:flutter/material.dart';

abstract final class AppRoutes {
  static MaterialPageRoute get start {
    return MaterialPageRoute(
      builder: (_) {
        return StartScreen();
      },
    );
  }

  static MaterialPageRoute get onBoarding {
    return MaterialPageRoute(
      builder: (_) {
        return OnBoardingScreen();
      },
    );
  }

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
  }

  static MaterialPageRoute get navigation {
    return MaterialPageRoute(
      builder: (_) {
        return NavigationScreen();
      },
    );
  }
  static MaterialPageRoute get addEvent {
    return MaterialPageRoute(
      builder: (_) {
        return AddEventScreen();
      },
    );
  }
  static MaterialPageRoute get eventDetails {
    return MaterialPageRoute(
        builder: (_) {
          return EventDetailsScreen();
        }
      );
  } static MaterialPageRoute get editEvent {
    return MaterialPageRoute(
        builder: (_) {
          return EditEventScreen();
        }
      );
  }
}
