import 'package:dotw/cards/card.dart';
import 'package:dotw/constants/colors.dart';
import 'package:dotw/entities/enemies/enemy.dart';
import 'package:dotw/entities/player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OffensiveCard extends GameCard {
  final int dmg;

  OffensiveCard({
    required super.title,
    required super.description,
    required super.cost,
    required this.dmg,
  });

  @override
  Widget render() {
    return Draggable<GameCard>(
      childWhenDragging: Container(),
      data: this,
      feedback: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.red,
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
                '$dmg',
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
          color: Colors.red,
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
                '$dmg',
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
    player.dmg.value = dmg;
    player.attack(enemy);
  }
}
