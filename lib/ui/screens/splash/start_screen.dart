import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/utils/app_textStyle.dart';
import 'package:evently/ui/widgets/custom_button.dart';
import 'package:evently/ui/widgets/custom_container_button.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool selectedLanguage = true;
  bool selectedMode = true;
  @override
  Widget build(BuildContext context) {
    var localization=AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.whiteBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              Image.asset(AppAssets.evtLogo),
              SizedBox(height: MediaQuery.of(context).size.height * .03),

              Image.asset(AppAssets.painting),
              SizedBox(height: MediaQuery.of(context).size.height * .03),

              Text(
               localization.personalizeYourExperience,
                style: AppTextStyle.black20semiBold,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .0075),

              Text(
               localization.choosePreferredThemeAndLanguage,
                style: AppTextStyle.darkGrey16Regular,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              buildThemeRow(
               localization.language,
                selectedLanguage ? AppColors.blue : AppColors.white,
                selectedLanguage ? AppColors.white : AppColors.blue,
                Text(
                  localization.english,
                  style: selectedLanguage
                      ? AppTextStyle.white14semiBold
                      : AppTextStyle.blue14semiBold,
                ),
                () {
                  selectedLanguage = true;
                  setState(() {});
                },
                Text(
                  localization.arabic,
                  style: selectedLanguage
                      ? AppTextStyle.blue14semiBold
                      : AppTextStyle.white14semiBold,
                ),
                () {
                  selectedLanguage = false;
                  setState(() {});
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .015),

              buildThemeRow(
               localization.theme,
                selectedMode ? AppColors.blue : AppColors.white,
                selectedMode ? AppColors.white : AppColors.blue,
                Icon(
                  Icons.light_mode_sharp,
                  color: selectedMode ? AppColors.white : AppColors.blue,
                ),
                () {
                  selectedMode = true;
                  setState(() {});
                },
                Icon(
                  Icons.dark_mode_outlined,
                  color: selectedMode ? AppColors.blue : AppColors.white,
                ),
                () {
                  selectedMode = false;
                  setState(() {});
                },
              ),
                Spacer(),
              CustomButton(
                text: localization.letsStart,
                onPress: () {
                  Navigator.push(context, AppRoutes.onBoarding);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildThemeRow(
    String text,
    Color background,
    Color background2,
    Widget widget1,
    void Function()? onClick,
    Widget widget2,
    void Function()? onClick2,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(text, style: AppTextStyle.blue18Medium)),
        CustomContainerButton(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 5.5),
          onClick: onClick,
          backGround: background,
          child: widget1,
        ),
        SizedBox(width: 8),
        CustomContainerButton(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 5.5),
          onClick: onClick2,
          backGround: background2,
          child: widget2,
        ),
      ],
    );
  }
}
