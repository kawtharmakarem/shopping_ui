import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../cubit/home_cubit.dart';
import '../../cubit/home_state.dart';
import '../../widgets/custom_buy_button.dart';
import '../../widgets/custom_men_card.dart';

class MenPage extends StatefulWidget {
  const MenPage({super.key});

  @override
  State<MenPage> createState() => _MenPageState();
}

class _MenPageState extends State<MenPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _scrollAnimation;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _scrollAnimation = List.generate(2, (index) {
      return Tween<Offset>(begin: Offset(0, 1), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.4 * index,
            0.4 * index + 0.6,
            curve: Curves.easeOutCubic,
          ),
        ),
      );
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();

        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: AppColors.grey,
              height: size.height,
              width: size.width,
            ),

            _bottomSheet(cubit),
            _upperSheet(cubit),

            // AnimatedPositioned(
            //   duration: Duration(milliseconds: 300),
            //   curve: Curves.easeOutBack,
            //   bottom: isShown ? 0 : -300,
            //   left: 0,
            //   right: 0,
            //   child: Container(
            //     height: size.height * 0.85,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       color: AppColors.white,
            //       borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            //       boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            //     ),
            //     child: Column(children: [

            //       ],
            //     ),
            //   ),
            // ),
          ],
        );
      },
    );
  }

  SlideTransition _upperSheet(HomeCubit cubit) {
    return SlideTransition(
      position: _scrollAnimation[1],
      child: DraggableScrollableSheet(
        expand: true,

        minChildSize: 0.1,
        maxChildSize: 0.8,
        initialChildSize: 0.1,
        builder: (context, scrollController) {
          return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.all(0),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Text(
                      "Shirts",
                      style: AppStyles.getBoldStyle(18)
                          .copyWith(color: AppColors.white),
                    ),
                    IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(padding: EdgeInsets.all(0)),
                      icon: Icon(
                        Icons.arrow_right,
                        size: 30,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                _mainUpperCard(cubit),
                SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: cubit.menFashion.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(cubit.menFashion[index].image),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Container _mainUpperCard(HomeCubit cubit) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.2,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.4,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              color: AppColors.grey,
              image: DecorationImage(
                image: AssetImage(cubit.menFashion[0].image),
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("COTTON SHIRT", style: AppStyles.getBoldStyle(16)),
              SizedBox(
                width: size.width * 0.3,
                child: Text(
                  "A modern style it has a narrow",
                  softWrap: true,
                  style: AppStyles.getRegularStyle(14)
                      .copyWith(color: Colors.black54),
                ),
              ),
              Text("£ 180", style: AppStyles.getBoldStyle(14)),
              CustomBuyButton(onPressed: () {}, title: "BUY NOW", textSize: 14),
            ],
          ),
        ],
      ),
    );
  }

  SlideTransition _bottomSheet(HomeCubit cubit) {
    Size size = MediaQuery.of(context).size;
    return SlideTransition(
      position: _scrollAnimation[0],
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: size.width,
          height: size.height * 0.85,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(
            children: [
              SizedBox(height: 30),
              Center(child: Text("Men", style: AppStyles.getBoldStyle(20))),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...List.generate(3, (index) {
                    return GestureDetector(
                      onTap: () {
                        cubit.changeCategory(index);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cubit.categoriesForMen[index],
                            style: AppStyles.getBoldStyle(16).copyWith(
                              color: cubit.categoryIndex == index
                                  ? AppColors.black
                                  : Colors.black54,
                            ),
                          ),
                          if (cubit.categoryIndex == index)
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: AppColors.lightRed,
                            ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: cubit.menFashion.length, //cubit.menFashion.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.6,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    return CustomMenCard(
                      cardModel: cubit.menFashion[index],
                      onTap: () {},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
