import 'package:flutter/material.dart';

class CardModel {
  final String image;
  final String title;
  final double price;
  final Color color;
  final String size;
  final String desc;
  final String kind;
  final double rate;
  final String details;

  CardModel({
    required this.image,
    required this.title,
    required this.price,
    required this.color,
    required this.size,
    required this.desc,
    required this.kind,
    required this.rate,
    required this.details,
  });
}
