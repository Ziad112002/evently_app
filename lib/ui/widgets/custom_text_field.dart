import 'package:evently/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../utils/app_textStyle.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool  isObscure;
  final int minLine;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isObscure=false,
    this.minLine=1,
    this.controller,
    this.validator
  });
  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.lightGrey),
    ); OutlineInputBorder errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.red),
    );
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText:isObscure,
      maxLines: isObscure?1:minLine+1,
      minLines: isObscure?1:minLine,
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
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
      ),
    );
  }
}
