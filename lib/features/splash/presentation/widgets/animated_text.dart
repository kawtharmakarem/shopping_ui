import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/strings_manger.dart';
import '../../../../core/resources/styles_manager.dart';

class AnimatedText extends StatelessWidget {
  const AnimatedText({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: ValueKey("Splash_text"),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.elasticOut,
      duration: Duration(milliseconds: 2000),
      builder: (context, value, child) {
        final double safeValue = value.clamp(0, 1);
        return Opacity(
          opacity: safeValue,
          child: Transform.scale(
            scale: value,
            child: Center(
              child: Text(
                AppStrings.spring,
                style: AppStyles.getBoldStyle(40).copyWith(
                  color: AppColors.white,
                  letterSpacing: (1 - safeValue) * 15 + 2,
                ),
                // style: TextStyle(
                //   fontSize: 40,
                //   fontWeight: FontWeight.bold,
                //   color: Colors.white,
                //   letterSpacing: (1 - safeValue) * 15 + 2,
                // ),
              ),
            ),
          ),
        );
      },
    );
  }
}
