import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../data/card_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  List<String> branch = ["Women", "Men", "Kids"];
  List<String> icons = ["Fb.", "Tw.", "In."];
  List<String> categoriesForMen = ["Latest", "Popular", "Sale"];
  List<CardModel> womenFashion = [
    CardModel(
      image: AssetsManager.imgOne,
      title: "Cocoon",
      price: 125,
      color: Colors.white,
      size: "L",
      desc: "Relaxed",
      kind: "Co-ords",
      rate: 4.8,
      details: "Lorem Ipsum is simply dummy text of the printing and typesetting industry .",
    ),
    CardModel(
      image: AssetsManager.imgThree,
      title: "Cocoon",
      price: 94,
      color: Colors.grey,
      size: "M",
      desc: "Relax",
      kind: "Linen",
      rate: 5.0,
      details: "Lorem Ipsum is simply dummy text of the printing and typesetting industry .",
    ),
    CardModel(
      image: AssetsManager.imgFour,
      title: "Cocoon",
      price: 150,
      color: Colors.blueGrey,
      size: "XL",
      desc: "Relaxed",
      kind: "Wide-Leg-Trousers",
      rate: 4.0,
      details: "Lorem Ipsum is simply dummy text of the printing and typesetting industry .",
    ),
    CardModel(
      image: AssetsManager.imgEight,
      title: "Cocoon",
      price: 170,
      color: Colors.orangeAccent,
      size: "M",
      desc: "Relax",
      kind: "Maxi Dresses",
      rate: 4.3,
      details: "Lorem Ipsum is simply dummy text of the printing and typesetting industry .",
    ),
  ];
  List<CardModel> menFashion = [
    CardModel(
      image: AssetsManager.imgTwo,
      title: "V-Nice JUMPER",
      price: 125,
      color: Colors.white,
      size: "L",
      desc: "Relaxed",
      kind: "Co-ords",
      rate: 4.8,
      details: "Lorem Ipsum is simply dummy text of the printing and typesetting industry .",
    ),
    CardModel(
      image: AssetsManager.imgTwo,
      title: "COTTON PARKEA",
      price: 94,
      color: Colors.grey,
      size: "M",
      desc: "Relax",
      kind: "Linen",
      rate: 5.0,
      details: "Lorem Ipsum is simply dummy text of the printing and typesetting industry .",
    ),
    CardModel(
      image: AssetsManager.imgTwo,
      title: "wOOL SEERSUCKER",
      price: 150,
      color: Colors.blueGrey,
      size: "XL",
      desc: "Relaxed",
      kind: "Wide-Leg-Trousers",
      rate: 4.0,
      details: "Lorem Ipsum is simply dummy text of the printing and typesetting industry .",
    ),
    CardModel(
      image: AssetsManager.imgTwo,
      title: "SHIRT WITH PROCKET",
      price: 170,
      color: Colors.orangeAccent,
      size: "M",
      desc: "Relax",
      kind: "Maxi Dresses",
      rate: 4.3,
      details: "Lorem Ipsum is simply dummy text of the printing and typesetting industry .",
    ),
    CardModel(
      image: AssetsManager.imgTwo,
      title: "SHIRT",
      price: 170,
      color: Colors.lightBlue,
      size: "M",
      desc: "Relax",
      kind: "Maxi Dresses",
      rate: 4.3,
      details: "Lorem Ipsum is simply dummy text of the printing and typesetting industry .",
    ),
    CardModel(
      image: AssetsManager.imgTwo,
      title: "SHIRT WITH PROCKET",
      price: 170,
      color: Colors.orangeAccent,
      size: "M",
      desc: "Relax",
      kind: "Maxi Dresses",
      rate: 4.3,
      details: "Lorem Ipsum is simply dummy text of the printing and typesetting industry .",
    ),
  ];
  int selectedIndex = 0;
  int selectedIcon = 0;
  int categoryIndex = 0;
  int? moveToIndex;
  //changeMoveIndex_womanPage
  void changeMoveIndex(int index) {
    moveToIndex = index;
    emit(ChangeMoveIndex());
  }

  //changeSelectedIndex_womenPage
  void changeSelectedIndex(int index) {
    selectedIndex = index;

    emit(ChangeSelectedIndex());
  }

  //moveIndexToNull_womanPage
  void moveIndexToNull() {
    moveToIndex = null;
    emit(MoveIndexToNull());
  }

  //changeIcon_womenPage
  void changeIcon(int index) {
    selectedIcon = index;
    emit(ChangeIcon());
  }

  //changeCategory_menPage
  void changeCategory(int index) {
    categoryIndex = index;
    emit(ChangeCategory());
  }
}
