import 'package:flutter/material.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../data/card_model.dart';
import '../../widgets/custom_buy_button.dart';
import '../../widgets/glass_container.dart';

class WomenDetail extends StatefulWidget {
  const WomenDetail({super.key, required this.cardModel});
  final CardModel cardModel;

  @override
  State<WomenDetail> createState() => _WomenDetailState();
}

class _WomenDetailState extends State<WomenDetail>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _controller;
  late List<Animation<double>> _scaleAnimation;
  late List<Animation<Offset>> _slideAnimation;
  late List<Animation<Offset>> _slideSideAnimation;
  late List<Animation<Offset>> _slideVerticalAnimation;
  late List<Animation<double>> _fadeVerticalAnimation;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double maxHeight = MediaQuery.of(context).size.height * 0.6;
      double minHeight = kToolbarHeight;
      double offset = _scrollController.offset;
      progress = (offset / (maxHeight - minHeight)).clamp(0, 1);
    });
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _scaleAnimation = List.generate(3, (index) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.2,
            (index * 0.2) + 0.5,
            curve: Curves.easeOutBack,
          ),
        ),
      );
    });
    _slideAnimation = List.generate(3, (index) {
      return Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0)).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.2 * index,
            0.5 + (0.2 * index),
            curve: Curves.easeOutBack,
          ),
        ),
      );
    });
    _slideSideAnimation = List.generate(3, (index) {
      return Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.2 * index,
            0.2 * index + 0.5,
            curve: Curves.easeOutBack,
          ),
        ),
      );
    });
    _slideVerticalAnimation = List.generate(3, (index) {
      return Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0)).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.3 * index,
            0.3 * index + 0.4,
            curve: Curves.easeOutBack,
          ),
        ),
      );
    });
    _fadeVerticalAnimation = List.generate(3, (index) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.3 * index, 0.3 * index + 0.4, curve: Curves.easeIn),
        ),
      );
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [_detailsAppBar(context), _womenDetailsContent()],
      ),
    );
  }

  SliverToBoxAdapter _womenDetailsContent() {
    Size size = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: SizedBox(
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  SlideTransition(
                    position: _slideSideAnimation[0],
                    child: Text(
                      widget.cardModel.desc,
                      style: AppStyles.getBoldStyle(50),
                    ),
                  ),
                  SizedBox(height: 5),
                  SlideTransition(
                    position: _slideSideAnimation[1],
                    child: Text(
                      widget.cardModel.kind,
                      style: AppStyles.getSemiBoldStyle(20),
                    ),
                  ),
                  SizedBox(height: 10),
                  SlideTransition(
                    position: _slideSideAnimation[2],
                    child: CustomBuyButton(onPressed: () {}, title: "BUY NOW"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SlideTransition(
                position: _slideVerticalAnimation[1],
                child: FadeTransition(
                  opacity: _fadeVerticalAnimation[1],
                  child: _rateBar(),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: _favoriteAndDetails(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _favoriteAndDetails() {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SlideTransition(
              position: _slideVerticalAnimation[2],
              child: FadeTransition(
                opacity: _fadeVerticalAnimation[2],
                child: SizedBox(
                  width: size.width * 0.6,
                  child: Text(
                    widget.cardModel.details,
                    style: AppStyles.getRegularStyle(16),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
        SlideTransition(
          position: _slideVerticalAnimation[0],
          child: FadeTransition(
            opacity: _fadeVerticalAnimation[0],
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.lightRed,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(color: AppColors.black),
                      child: Icon(
                        Icons.lock_open,
                        size: 30,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _rateBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 5,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Row(
          children: [
            Text(
              widget.cardModel.rate.toString(),
              style: AppStyles.getSemiBoldStyle(18),
            ),
            Icon(Icons.star, size: 20),
          ],
        ),
      ],
    );
  }

  SliverAppBar _detailsAppBar(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SliverAppBar(
      expandedHeight: size.height * 0.5,
      collapsedHeight: kToolbarHeight,
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      backgroundColor: AppColors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
      ),
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        title: LayoutBuilder(
          builder: (context, constraints) {
            double currentHeight = constraints.biggest.height;
            double maxHeight = size.height * 0.5;
            double minHeight = kToolbarHeight;
            double opacity =
                ((maxHeight - currentHeight) / (maxHeight - minHeight)).clamp(
                  0,
                  1,
                );
            return Opacity(
              opacity: opacity,
              child: Text(widget.cardModel.title),
            );
          },
        ),
        background: Stack(
          children: [
            Hero(
              tag: widget.cardModel.image,
              child: Image.asset(widget.cardModel.image, fit: BoxFit.cover),
            ),
            Positioned(
              bottom: 20,
              left: 50,
              child: Row(
                //mainAxisSize: MainAxisSize.min,
                children: [
                  SlideTransition(
                    position: _slideAnimation[0],
                    child: ScaleTransition(
                      scale: _scaleAnimation[0],
                      child: GlassContainer(
                        width: 85,
                        height: 85,
                        title: "Color",
                        child: CircleAvatar(
                          backgroundColor: widget.cardModel.color,
                          radius: 10,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SlideTransition(
                    position: _slideAnimation[1],
                    child: ScaleTransition(
                      scale: _scaleAnimation[1],
                      child: GlassContainer(
                        width: 85,
                        height: 85,
                        title: "Price",
                        child: Text(
                          "£ ${widget.cardModel.price}",
                          style: AppStyles.getBoldStyle(16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SlideTransition(
                    position: _slideAnimation[2],
                    child: ScaleTransition(
                      scale: _scaleAnimation[2],
                      child: GlassContainer(
                        width: 85,
                        height: 85,
                        title: "Size",
                        child: Text(
                          widget.cardModel.size,
                          style: AppStyles.getBoldStyle(16),
                        ),
                      ),
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
