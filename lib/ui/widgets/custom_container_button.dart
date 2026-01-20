import 'package:evently/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomContainerButton extends StatelessWidget {
  final VoidCallback? onClick;
  final Widget widget;
  final Color backGround;
  final EdgeInsets padding;
  const CustomContainerButton({
    super.key,
    required this.onClick,
    required this.widget,
    this.backGround=AppColors.white,
    this.padding=  const EdgeInsets.all(8)
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
        child: widget,
      ),
    );
  }
}
