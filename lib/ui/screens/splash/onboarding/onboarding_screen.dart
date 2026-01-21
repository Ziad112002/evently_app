import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/main.dart';
import 'package:evently/ui/models/onboarding_dm.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_constants.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/utils/app_textStyle.dart';
import 'package:evently/ui/widgets/custom_button.dart';
import 'package:evently/ui/widgets/custom_container_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();
  int currentIndex = 0;



  @override
  Widget build(BuildContext context) {
     AppLocalizations localization = AppLocalizations.of(context)!;
    List<OnboardingDm>onboardingData = [
      OnboardingDm(
        imagePath: AppAssets.trending,
        title: localization.onboardingFindTitle,
        desc: localization.onboardingFindDesc,
      ),
      OnboardingDm(
        imagePath: AppAssets.planing,
        title: localization.onboardingManageTitle,
        desc: localization.onboardingManageDesc,
      ),
      OnboardingDm(
        imagePath: AppAssets.social,
        title: localization.onboardingConnectTitle,
        desc: localization.onboardingConnectDesc,
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.whiteBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              buildHeader(),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              SizedBox(
                height: MediaQuery.of(context).size.height * .42,
                child: PageView.builder(
                  controller: controller,
                  onPageChanged: _onPagedChanged,
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) {
                    return Image.asset(onboardingData[index].imagePath);
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              Center(child: buildSmoothPageIndicator()),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              Text(
                onboardingData[currentIndex].title,
                style: AppTextStyle.black20semiBold,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              Text(
                onboardingData[currentIndex].desc,
                style: AppTextStyle.darkGrey16Regular,
                textAlign: TextAlign.start,
              ),
              Spacer(),
              CustomButton(
                text: currentIndex == 2 ? localization.getStarted : localization.next,
                onPress: () async{
                  currentIndex != 2
                      ? _nextPage()
                      : Navigator.push(context, AppRoutes.login);
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool(AppConstants.displayOnboarding, false);

                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: currentIndex == 0 ? false : true,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: CustomContainerButton(
            onClick: () {
              _previousPage();
            },
            child: Icon(Icons.arrow_back_ios_new, color: AppColors.blue),
          ),
        ),
        Image.asset(AppAssets.evtLogo),
        Visibility(
          visible: currentIndex == 2 ? false : true,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: CustomContainerButton(
            onClick: () {
              _nextPage();
            },
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5.5),
            child: Text(AppLocalizations.of(context)!.skip, style: AppTextStyle.blue14semiBold),
          ),
        ),
      ],
    );
  }

  Widget buildSmoothPageIndicator() {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
      effect: ExpandingDotsEffect(
        activeDotColor: AppColors.blue,
        dotColor: AppColors.grey,
        dotHeight: 8,
        dotWidth: 8,
      ),
    );
  }

  void _onPagedChanged(int index) {
    currentIndex = index;
    setState(() {});
  }

  void _previousPage() {
    if (currentIndex == 0) {
      return;
    } else {
      controller.previousPage(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
  }

  void _nextPage() {
    if (currentIndex == 2) {
      return;
    } else {
      controller.nextPage(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
  }
}
