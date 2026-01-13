import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_textStyle.dart';
import 'package:evently/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*.17,
                  ),
                  Text("Forget Password",style: AppTextStyle.black18Medium,)
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*.04,
              ),
              Image.asset(AppAssets.changeSetting),
              SizedBox(
                height: MediaQuery.of(context).size.height*.055,
              ),
              CustomButton(text: "Reset password", onPress: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
