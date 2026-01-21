import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_dialogs.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/utils/app_textStyle.dart';
import 'package:evently/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = false;
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
                Text(
                  localization.loginTitle,
                  style: AppTextStyle.blue24semiBold,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .03),
                CustomTextField(
                  hintText: localization.emailHint,
                  prefixIcon: Image.asset(AppAssets.mailLogo),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                CustomTextField(
                  hintText:localization.passwordHint,
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
                SizedBox(height: MediaQuery.of(context).size.height * .01),
                InkWell(
                  onTap: () {
                    Navigator.push(context, AppRoutes.forgotPassword);
                  },
                  overlayColor: WidgetStatePropertyAll(Colors.transparent),

                  child: Text(
                   localization.forgotPassword,
                    style: AppTextStyle.blue14semiBold.copyWith(
                      decoration: TextDecoration.underline,
                      color: AppColors.blue,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .06),
                buildLoginButton(),
                SizedBox(height: MediaQuery.of(context).size.height * .06),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      localization.noAccount,
                      style: AppTextStyle.darkGrey14Regular,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, AppRoutes.signup);
                      },
                      child: Text(
                        localization.signup,
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
                  text: localization.googleLogin,
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

  Widget buildLoginButton() {
    return CustomButton(
      text:localization.loginButton ,
      onPress: () async {
        showLoading(context);
        await Future.delayed(Duration(seconds: 1));
        Navigator.pop(context);
        showMessage(
          context,
         localization.errorMessage,
          title: localization.errorTitle,
          negText: localization.dialogCancel,
          posText: localization.dialogOk,
         
        );
      },
    );
  }
}
