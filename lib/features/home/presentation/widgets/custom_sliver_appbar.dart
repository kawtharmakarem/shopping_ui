import 'package:flutter/material.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/strings_manger.dart';
import '../../../../core/resources/styles_manager.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.slide1,
    required this.slide2,
    required this.slide3,
  });

  final Animation<Offset> slide1;
  final Animation<Offset> slide2;
  final Animation<Offset> slide3;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SliverAppBar(
      collapsedHeight: kToolbarHeight,
      expandedHeight: size.height * 0.5,
      pinned: true,
      backgroundColor: AppColors.grey,
      centerTitle: true,

      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        title: LayoutBuilder(
          builder: (context, constraints) {
            double currentHeight = constraints.biggest.height;
            double maxHeight = size.width * 0.5;
            double minHeight = kToolbarHeight;
            double opacity =
                ((maxHeight - currentHeight) / (maxHeight - minHeight)).clamp(
                  0,
                  1,
                );
            return Opacity(
              opacity: opacity,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - opacity)),
                child: Text(
                  AppStrings.title,
                  style: AppStyles.getBoldStyle(
                    20,
                  ).copyWith(color: AppColors.white),
                ),
              ),
            );
          },
        ),

        background: Stack(
          children: [
            Container(
              alignment: Alignment.topRight,
              color: AppColors.grey,
              child: Image.asset(AssetsManager.imgThree, fit: BoxFit.cover),
            ),
            Positioned(
              top: -20,
              child: RotatedBox(
                quarterTurns: -3,
                child: Text(
                  AppStrings.fashion,
                  style: AppStyles.getBoldStyle(
                    50,
                  ).copyWith(color: AppColors.white70),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 30,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SlideTransition(
                    position: slide1,
                    child: Text(
                      AppStrings.justForYou,
                      style: AppStyles.getBoldStyle(16),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  SlideTransition(
                    position: slide2,
                    child: Text(
                      AppStrings.spring,
                      style: AppStyles.getBoldStyle(40),
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  SlideTransition(
                    position: slide3,
                    child: Text(
                      AppStrings.collection,
                      style: AppStyles.getBoldStyle(16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
