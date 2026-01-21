import 'package:evently/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomContainerButton extends StatelessWidget {
  final VoidCallback? onClick;
  final Widget child;
  final Color backGround;
  final EdgeInsets padding;
  const CustomContainerButton({
    super.key,
    required this.onClick,
    required this.child,
    this.backGround=AppColors.white,
    this.padding=  const EdgeInsets.all(4)
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onClick,
      child: Container(

        padding:padding,
        decoration: BoxDecoration(
          color: backGround,
          borderRadius: BorderRadius.circular(8),
        ),
        child: child,
      ),
    );
  }
}
