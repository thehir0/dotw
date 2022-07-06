import 'package:flutter/material.dart';

class GameColors {
  static const Color barColor = Color.fromRGBO(63, 73, 79, 1);
  static const Color goldColor = Color.fromRGBO(255, 215, 0, 1);
  static const Color first = Color.fromRGBO(52, 97, 155, 1);
  static const Color second = Color.fromRGBO(0, 172, 189, 1);
  static const Color third = Color.fromRGBO(143, 231, 134, 1);
  static const Color black50 = Color.fromRGBO(36, 40, 45, 0.5);
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
