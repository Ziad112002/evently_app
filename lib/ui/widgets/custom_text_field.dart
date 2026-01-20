import 'package:evently/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../utils/app_textStyle.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool  isObscure;
  final int minLine;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isObscure=false,
    this.minLine=1
  });
  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.lightGrey),
    );
    return TextFormField(
      obscureText:isObscure,
      maxLines: minLine+1,
      minLines: minLine,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hint: Text(hintText),
        hintStyle: AppTextStyle.darkGrey14Regular,
        fillColor: AppColors.white,
        filled: true,
        border: border,
        enabledBorder: border,
        disabledBorder: border,
        focusedBorder: border,
        errorBorder: border,
        focusedErrorBorder: border,
      ),
    );
  }
}
