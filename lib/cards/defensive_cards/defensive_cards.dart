import 'package:dotw/cards/card.dart';
import 'package:dotw/entities/enemies/enemy.dart';
import 'package:dotw/entities/player.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';

class DefensiveCard extends GameCard {
  final int block;

  DefensiveCard({
    required super.title,
    required super.description,
    required super.cost,
    required this.block,
  });

  @override
  Widget render() {
    return Draggable<GameCard>(
      childWhenDragging: Container(),
      data: this,
      feedback: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.blue,
        ),
        height: GameCard.cardHeight,
        width: GameCard.cardWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                '$cost',
                style: GoogleFonts.vt323(
                    textStyle: const TextStyle(fontSize: 30),
                    color: GameColors.goldColor),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                '$block',
                style: GoogleFonts.vt323(
                    textStyle: const TextStyle(fontSize: 30),
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.blue,
        ),
        height: GameCard.cardHeight,
        width: GameCard.cardWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                '$cost',
                style: GoogleFonts.vt323(
                    textStyle: const TextStyle(fontSize: 30),
                    color: GameColors.goldColor),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                '$block',
                style: GoogleFonts.vt323(
                    textStyle: const TextStyle(fontSize: 30),
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void play(Player player, Enemy enemy) {
    player.block.value += block;
  }
}
