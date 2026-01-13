import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/utils/app_textStyle.dart';
import 'package:evently/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.evtLogo),
              SizedBox(
                height: MediaQuery.of(context).size.height*.06,
              ),
              Text("Login to your account", style: AppTextStyle.blue24semiBold),
              SizedBox(
                height: MediaQuery.of(context).size.height*.03,
              ),
              CustomTextField(
                hintText: "Enter your email",
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SvgPicture.asset(AppAssets.mail),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*.02,
              ),
              CustomTextField(
                hintText: "Enter your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SvgPicture.asset(AppAssets.lock),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SvgPicture.asset(AppAssets.visible),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*.01,
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, AppRoutes.forgotPasswordScreen);
                },
                overlayColor: WidgetStatePropertyAll(Colors.transparent),

                child: Text(
                  "Forgot Password? ",
                  style: AppTextStyle.blue14semiBold.copyWith(
                    decoration: TextDecoration.underline,
                    color: AppColors.blue,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*.06,
              ),
              CustomButton(text: "Login", onPress: () {}),
              SizedBox(
                height: MediaQuery.of(context).size.height*.06,
              ),
              Row(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    "Don’t have an account ? ",
                    style: AppTextStyle.darkGrey14Regular,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, AppRoutes.signupScreen);
                    },
                    child: Text(
                      "Signup",
                      style: AppTextStyle.blue14semiBold.copyWith(
                        decoration: TextDecoration.underline,
                        color: AppColors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*.04,
              ),
              Text(
                "Or ",
                style: AppTextStyle.blue16Medium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*.03,
              ),
              CustomButton(
                background: AppColors.white,
                text: "Login with Google",
                style: AppTextStyle.blue16Medium,
                icon: Image.asset(AppAssets.googleLogo, height: 24,width: 24,),
                onPress: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//.06 .03 .02 .01 .06 .06 .04 .03