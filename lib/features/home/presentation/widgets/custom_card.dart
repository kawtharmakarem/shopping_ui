import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../data/card_model.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.cardModel,
    required this.progress,
    required this.onTap,
  });
  final CardModel cardModel;
  final double progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 2,

        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: size.height * 0.22,
          width: size.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
          ),
          child: progress > 0.5
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.4,
                      height: size.height * 0.22,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(cardModel.image),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        color: AppColors.grey,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          cardModel.title,
                          style: AppStyles.getMediumStyle(14),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '£ ${cardModel.price}',
                          style: AppStyles.getRegularStyle(14),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.4,
                      height: size.height * 0.16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        color: AppColors.grey,
                      ),
                      child: Hero(
                        tag: cardModel.image,
                        child: Image.asset(cardModel.image, fit: BoxFit.cover),
                      ),
                    ),
                    Text(cardModel.title, style: AppStyles.getMediumStyle(14)),
                    SizedBox(height: 2),
                    Text(
                      '£ ${cardModel.price}',
                      style: AppStyles.getRegularStyle(14),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
