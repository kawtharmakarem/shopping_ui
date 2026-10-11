import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../widgets/animated_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _startTextAnimation = false;
  Timer? _timer;
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _startTextAnimation = true;
          _timer = Timer(
            Duration(seconds: AppConstants.splashDuration),
            _goNext,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: AppColors.grey,
        child: _startTextAnimation ? AnimatedText() : SizedBox(),
      ),
    );
  }

  void _goNext() {
    Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
  }
}
