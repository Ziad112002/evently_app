import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_textStyle.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color background;
  final Widget? icon;
  final VoidCallback? onPress;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPress,
    this.icon,
    this.style = AppTextStyle.white20Medium,
    this.background = AppColors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        padding: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        )
      ),
      onPressed: onPress,
      child: Row(
        mainAxisAlignment: .center,
        children: [
          if (icon != null) ...[icon!, SizedBox(width: 9)],
          Text(text, style: style),
        ],
      ),
    );
  }
}
