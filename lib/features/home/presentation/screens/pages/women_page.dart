//import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/strings_manger.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../data/card_model.dart';
import '../../cubit/home_cubit.dart';
import '../../cubit/home_state.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_sliver_appbar.dart';
import '../details_pages/women_detail.dart';

class WomenPage extends StatefulWidget {
  const WomenPage({super.key});

  @override
  State<WomenPage> createState() => _WomenPageState();
}

class _WomenPageState extends State<WomenPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  double progress = 0;
  late AnimationController _sheetController;
  late Animation<Offset> slideAnimation;
  late Animation<Offset> sideSlideAnimation;

  late Animation<Offset> slide1;
  late Animation<Offset> slide2;
  late Animation<Offset> slide3;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double maxHeight = MediaQuery.of(context).size.height * 0.5;
      double minHeight = kToolbarHeight;
      double offset = _scrollController.offset;
      progress = (offset / (maxHeight - minHeight)).clamp(0, 1);
      setState(() {});
    });

    _sheetController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    slideAnimation = Tween<Offset>(begin: Offset(0, 0.6), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _sheetController,
            curve: Interval(0, 0.6, curve: Curves.easeOutCubic),
          ),
        );
    sideSlideAnimation =
        Tween<Offset>(begin: Offset(-1.2, 0), end: Offset(0, 0)).animate(
          CurvedAnimation(
            parent: _sheetController,
            curve: Interval(0.5, 1, curve: Curves.easeOutBack),
          ),
        );
    slide1 = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _sheetController,
        curve: Interval(0, 0.5, curve: Curves.easeOut),
      ),
    );
    slide2 = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _sheetController,
        curve: Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );
    slide3 = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _sheetController,
        curve: Interval(0.4, 1, curve: Curves.easeOut),
      ),
    );
    _sheetController.forward();
  }

  @override
  void dispose() {
    _sheetController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();

        return Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                CustomAppBar(slide1: slide1, slide2: slide2, slide3: slide3),

                SliverToBoxAdapter(
                  child: SizedBox(
                    height: size.height,
                    child: SlideTransition(
                      position: slideAnimation,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 40),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _header(),
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 400),
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: Offset(0.2, 0),
                                      end: Offset(0, 0),
                                    ).animate(animation),
                                    child: child,
                                  ),
                                );
                              },
                              child: progress < 0.5
                                  ? _buildHorizontalListView(cubit)
                                  : _buildVerticalListView(cubit),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _blackBoard(cubit),
          ],
        );
      },
    );
  }

  Widget _animatedItem(CardModel cardModel) {
    double width = lerpDouble(
      MediaQuery.of(context).size.height * 0.19,
      MediaQuery.of(context).size.width,
      progress,
    )!;
    double scale = lerpDouble(0.9, 1, progress)!;
    double padding = lerpDouble(8, 12, progress)!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 6),
      child: Align(
        alignment: Alignment.center,
        child: Transform.scale(
          scale: scale,
          child: SizedBox(
            width: width,
            child: CustomCard(
              cardModel: cardModel,
              progress: progress,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WomenDetail(cardModel: cardModel),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Row _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(AppStrings.seeAlso, style: AppStyles.getMediumStyle(16)),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_right_rounded,
            size: 40,
            color: AppColors.lightRed,
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalListView(HomeCubit cubit) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        scrollDirection: Axis.horizontal,
        key: ValueKey("horizontal"),
        itemCount: cubit.womenFashion.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 10),
            child: _animatedItem(cubit.womenFashion[index]),
            // CustomCard(
            //   cardModel: cubit.womenFashion[index],
            //   progress: progress,
            // ),
          );
        },
      ),
    );
  }

  Widget _buildVerticalListView(HomeCubit cubit) {
    return SizedBox(
      height: 700,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(0),
        key: ValueKey("Vertical"),
        itemCount: cubit.womenFashion.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _animatedItem(cubit.womenFashion[index]),
            // CustomCard(
            //   cardModel: cubit.womenFashion[index],
            //   progress: progress,
            // ),
          );
        },
      ),
    );
  }

  Widget _blackBoard(HomeCubit cubit) {
    Size size = MediaQuery.of(context).size;

    return progress >= 0.9
        ? SizedBox()
        : Transform.translate(
            offset: Offset(size.width / 2, size.height * 0.5 * (1 - progress)),
            child: SlideTransition(
              position: sideSlideAnimation,
              child: Container(
                height: size.height * 0.12,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  color: AppColors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(cubit.icons.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        cubit.changeIcon(index);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            cubit.icons[index],
                            style: AppStyles.getMediumStyle(16).copyWith(
                              color: cubit.selectedIcon == index
                                  ? AppColors.lightRed
                                  : AppColors.white,
                            ),
                          ),
                          if (cubit.selectedIcon == index)
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: AppColors.lightRed,
                            ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
  }
}
