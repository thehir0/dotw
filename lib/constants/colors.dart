import 'package:flutter/material.dart';

class GameColors {
  static const Color barColor = Color.fromRGBO(63, 73, 79, 1);
  static const Color goldColor = Color.fromRGBO(255, 215, 0, 1);
  static const Color first = Color.fromRGBO(52, 97, 155, 1);
  static const Color second = Color.fromRGBO(0, 172, 189, 1);
  static const Color third = Color.fromRGBO(143, 231, 134, 1);
  static const Color black50 = Color.fromRGBO(36, 40, 45, 0.5);
  static const Color black10 = Color.fromRGBO(36, 40, 45, 0.1);
  static const Color pastel = Color.fromRGBO(255, 252, 217, 1);
  static const Color red1 = Color.fromRGBO(219, 73, 53, 1);
  static const Color blue1 = Color.fromRGBO(65, 102, 245, 1);
  static const Color silver = Color.fromRGBO(192, 192, 192, 1);
  static const Color bronze = Color.fromRGBO(205, 127, 50, 1);
}

class Gradients {
  static const grad2 = LinearGradient(colors: [
    GameColors.second,
    GameColors.third,
  ]);

  static const grad2_2 = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        GameColors.second,
        GameColors.third,
      ]);
}
