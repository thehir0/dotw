import 'package:flutter/material.dart';

abstract class GameCard extends StatelessWidget {
  const GameCard({Key? key}) : super(key: key);

}

class AttackCard extends GameCard {
  static double cardHeight = 124;
  static double cardWidth = 80;
  const AttackCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      childWhenDragging: Container(),
      data: 10,
      feedback: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.red,
        ),
        height: cardHeight,
        width: cardWidth,
      ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          color: Colors.red,
        ),
        height: cardHeight,
        width: cardWidth,
      ),
    );
  }
}

class DefenceCard extends GameCard {
  const DefenceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double cardHeight = 124;
    const double cardWidth = 80;
    return Draggable<int>(
      childWhenDragging: Container(),
      data: 10,
      feedback: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          color: Colors.blue,
        ),
        height: cardHeight,
        width: cardWidth,
      ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          color: Colors.blue,
        ),
        height: cardHeight,
        width: cardWidth,
      ),
    );
  }
}

