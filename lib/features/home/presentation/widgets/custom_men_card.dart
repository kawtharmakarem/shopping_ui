import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../data/card_model.dart';
import 'custom_buy_button.dart';

class CustomMenCard extends StatelessWidget {
  const CustomMenCard({
    super.key,
    required this.cardModel,
    required this.onTap,
  });
  final CardModel cardModel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 2,

        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        color: AppColors.grey,
                      ),
                      child: Hero(
                        tag: cardModel.title,
                        child: Image.asset(
                          cardModel.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cardModel.title,
                          style: AppStyles.getMediumStyle(14),
                        ),
                        Text(
                          '£ ${cardModel.price}',
                          style: AppStyles.getRegularStyle(14),
                        ),
                        CustomBuyButton(
                          onPressed: () {},
                          title: "BUY NOW",
                          textSize: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
