import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';

class CustomBuyButton extends StatelessWidget {
  const CustomBuyButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.textSize,
  });
  final VoidCallback onPressed;
  final String title;
  final double? textSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,

      style: TextButton.styleFrom(
        foregroundColor: AppColors.lightRed,
        padding: EdgeInsets.all(0),
        splashFactory: InkRipple.splashFactory,
        //backgroundColor: Colors.red.withValues(alpha: 0.1),
        textStyle: AppStyles.getBoldStyle(textSize ?? 18),
      ),
      child: Text(title),
    );
  }
}
