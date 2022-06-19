import 'package:dotw/cards/card.dart';
import 'package:dotw/entities/enemies/enemy.dart';
import 'package:dotw/entities/player.dart';
import 'package:flutter/material.dart';

class DefensiveCard extends GameCard {
  final int block;

  DefensiveCard({
    required super.title,
    required super.description,
    required super.cost,
    required this.block,
  });

  @override
  Widget render(){
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
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.blue,
        ),
        height: GameCard.cardHeight,
        width: GameCard.cardWidth,
      ),
    );
  }

  @override
  void play(Player player, Enemy enemy) {
    player.block.value += block;
  }
}
