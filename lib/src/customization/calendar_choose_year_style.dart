import 'package:flutter/material.dart';

class CalendarChooseYearStyle {
  final Decoration unChooseYearDecoration;
  final Decoration chooseYearDecoration;
  final Decoration disableYearDecoration;
  final TextStyle unChooseTextStyle;
  final TextStyle chooseTextStyle;
  final TextStyle disableTextStyle;

  CalendarChooseYearStyle({
    this.unChooseTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    this.chooseTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    this.disableTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    ),
    this.unChooseYearDecoration = const BoxDecoration(
      color: Colors.white,
    ),
    this.chooseYearDecoration = const BoxDecoration(
      color: Colors.blueAccent,
    ),
    this.disableYearDecoration = const BoxDecoration(),
  });
}
