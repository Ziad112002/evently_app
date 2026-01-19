import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/utils/app_textStyle.dart';
import 'package:evently/ui/widgets/custom_button.dart';
import 'package:evently/ui/widgets/custom_container_button.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                "Personalize Your Experience",
                style: AppTextStyle.black20semiBold,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .0075),

              Text(
                "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
                style: AppTextStyle.darkGrey16Regular,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              buildThemeRow(
                "Language",
                Text("English", style: AppTextStyle.white14semiBold),
                Text("Arabic", style: AppTextStyle.blue14Regular),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .015),

              buildThemeRow(
                "Theme",
                Icon(Icons.light_mode_sharp, color: Colors.white),
                Icon(Icons.dark_mode_outlined, color: AppColors.blue),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .04),
              CustomButton(text: "Let's start", onPress: () {
                Navigator.push(context, AppRoutes.onBoarding);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildThemeRow(String text, Widget widget1, Widget widget2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(text, style: AppTextStyle.blue18Medium)),
        CustomContainerButton(
          onClick: () {},
          backGround: AppColors.blue,
          widget: widget1,
        ),
        SizedBox(width: 8),
        CustomContainerButton(onClick: () {}, widget: widget2),
      ],
    );
  }
}
