import 'package:flutter/material.dart';

class CalendarChooseMonthStyle {
  final Decoration unChooseMonthDecoration;
  final Decoration chooseMonthDecoration;
  final Decoration disableMonthDecoration;
  final TextStyle unChooseTextStyle;
  final TextStyle chooseTextStyle;
  final TextStyle disableTextStyle;

  CalendarChooseMonthStyle({
    this.unChooseMonthDecoration = const BoxDecoration(
      color: Colors.white,
    ),
    this.chooseMonthDecoration = const BoxDecoration(
      color: Colors.blueAccent,
    ),
    this.disableMonthDecoration = const BoxDecoration(),
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
  });
}
