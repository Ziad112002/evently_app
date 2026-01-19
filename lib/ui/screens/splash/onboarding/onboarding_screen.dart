import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_textStyle.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBlue,
      appBar: AppBar(),
      body: Center(
        child: Text("Data",style: AppTextStyle.blue24semiBold,),
      ),
    );
  }
}
