import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../cubit/home_cubit.dart';

class AnimatedBottomNavigation extends StatelessWidget {
  const AnimatedBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / cubit.branch.length;
          return Stack(
            children: [
              AnimatedPositioned(
                left: cubit.selectedIndex * itemWidth,
                curve: Curves.easeOut,
                duration: Duration(milliseconds: 400),
                child: Container(
                  alignment: Alignment.center,
                  height: 80,
                  width: itemWidth,
                  child: TweenAnimationBuilder<double>(
                    key: ValueKey(cubit.moveToIndex),
                    tween: Tween<double>(
                      begin: 1,
                      end: cubit.moveToIndex != null ? 1.6 : 1,
                    ),

                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeOut,
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scaleX: scale,
                        alignment: cubit.moveToIndex != null
                            ? (cubit.moveToIndex! > cubit.selectedIndex)
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight
                            : Alignment.center,
                        child: child,
                      );
                    },

                    child: Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        color: AppColors.lightRed,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(cubit.branch.length, (index) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // setState(() {
                          //   moveToIndex = index;
                          // });
                          cubit.changeMoveIndex(index);
                          Future.delayed(Duration(milliseconds: 50), () {
                            // setState(() {
                            //   selectedIndex = index;
                            // });
                            cubit.changeSelectedIndex(index);
                          });
                          Future.delayed(Duration(milliseconds: 400), () {
                            // setState(() {
                            //   moveToIndex = null;
                            // });
                            cubit.moveIndexToNull();
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: AnimatedDefaultTextStyle(
                            style:
                                AppStyles.getMediumStyle(
                                  cubit.selectedIndex == index ? 16 : 14,
                                ).copyWith(
                                  color: cubit.selectedIndex == index
                                      ? AppColors.white
                                      : AppColors.black,
                                ),
                            duration: Duration(milliseconds: 300),
                            child: AnimatedOpacity(
                              opacity: cubit.selectedIndex == index ? 1 : 0.6,
                              duration: Duration(milliseconds: 300),
                              child: AnimatedSlide(
                                offset: cubit.selectedIndex == index
                                    ? Offset(0, 0)
                                    : Offset(0, 0.2),
                                duration: Duration(milliseconds: 300),
                                child: Text(cubit.branch[index]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
