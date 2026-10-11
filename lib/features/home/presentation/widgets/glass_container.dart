import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/resources/styles_manager.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    required this.title,
  });
  final double width;
  final double height;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          alignment: Alignment.center,
          width: width,

          height: height,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppStyles.getSemiBoldStyle(
                  14,
                ).copyWith(color: Colors.black54),
              ),
              SizedBox(height: 10),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
