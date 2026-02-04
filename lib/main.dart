
import 'package:evently/ui/providers/language_provider.dart';
import 'package:evently/ui/screens/login/login_screen.dart';
import 'package:evently/ui/screens/splash/start_screen.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/app_localizations.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  AppConstants.showOnboarding=prefs.getBool(AppConstants.displayOnboarding)??true;
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
    statusBarColor: AppColors.whiteBlue
  ),);
  runApp( ChangeNotifierProvider(
    create:  (context) => LanguageProvider(),
      child: const Evently()));
}

class Evently extends StatelessWidget {
  const Evently({super.key});


  @override
  Widget build(BuildContext context) {
    LanguageProvider provider=Provider.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates:  AppLocalizations.localizationsDelegates,
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],
      locale: Locale(provider.currentLocale),
      home: AppConstants.showOnboarding!?StartScreen():LoginScreen(),
    );
  }
}
