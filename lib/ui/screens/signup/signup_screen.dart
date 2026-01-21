import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_textStyle.dart';
import 'package:evently/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isObscure = false;
  bool isObscure2 = false;
  late var localization=AppLocalizations.of(context)!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(AppAssets.evtLogo),
                SizedBox(height: MediaQuery.of(context).size.height * .06),
                Text(localization.createYourAccount, style: AppTextStyle.blue24semiBold),
                SizedBox(height: MediaQuery.of(context).size.height * .03),
                CustomTextField(
                  hintText: localization.enterYourName,
                  prefixIcon: Image.asset(AppAssets.personLogo),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                CustomTextField(
                  hintText: localization.emailHint,
                  prefixIcon: Image.asset(AppAssets.mailLogo),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                CustomTextField(
                  hintText: localization.passwordHint,
                  isObscure: isObscure,
                  prefixIcon: Image.asset(AppAssets.lockLogo),
                  suffixIcon: InkWell(
                    onTap: () {
                      isObscure = !isObscure;
                      setState(() {});
                    },
                    child: isObscure
                        ? Icon(
                            Icons.remove_red_eye_outlined,
                            color: AppColors.grey,
                          )
                        : Image.asset(AppAssets.eyeLogo),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                CustomTextField(
                  hintText: localization.confirmYourPassword,
                  isObscure: isObscure2,
                  prefixIcon: Image.asset(AppAssets.lockLogo),
                  suffixIcon: InkWell(
                    onTap: () {
                      isObscure2 = !isObscure2;
                      setState(() {});
                    },
                    child: isObscure2
                        ? Icon(
                            Icons.remove_red_eye_outlined,
                            color: AppColors.grey,
                          )
                        : Image.asset(AppAssets.eyeLogo),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * .06),
                CustomButton(text: localization.signup, onPress: () {}),
                SizedBox(height: MediaQuery.of(context).size.height * .06),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      localization.alreadyHaveAccount,
                      style: AppTextStyle.darkGrey14Regular,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        localization.login,
                        style: AppTextStyle.blue14semiBold.copyWith(
                          decoration: TextDecoration.underline,
                          color: AppColors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .04),
                Text(
                  localization.orText,
                  style: AppTextStyle.blue16Medium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .03),
                CustomButton(
                  background: AppColors.white,
                  text: localization.signUpWithGoogle,
                  style: AppTextStyle.blue16Medium,
                  icon: Image.asset(
                    AppAssets.googleLogo,
                    height: 24,
                    width: 24,
                  ),
                  onPress: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//.06 .03 .02 .01 .06 .06 .04 .03
