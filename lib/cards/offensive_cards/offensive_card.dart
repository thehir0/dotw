import 'package:dotw/cards/card.dart';
import 'package:dotw/entities/enemies/enemy.dart';
import 'package:dotw/entities/player.dart';
import 'package:flutter/material.dart';

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
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.red,
        ),
        height: GameCard.cardHeight,
        width: GameCard.cardWidth,
      ),
    );
  }

  @override
  void play(Player player, Enemy enemy) {
    player.dmg.value = dmg;
    player.attack(enemy);
  }
}
