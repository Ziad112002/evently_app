import 'package:evently/ui/screens/login/login_screen.dart';
import 'package:evently/ui/screens/navigation/navigation_screen.dart';
import 'package:evently/ui/screens/splash/start_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Evently());
}

class Evently extends StatelessWidget {
  const Evently({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationScreen(),
    );
  }
}
