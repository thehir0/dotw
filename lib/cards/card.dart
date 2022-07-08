import 'package:dotw/cards/list_of_card.dart';
import 'package:dotw/cards/offensive_cards/offensive_card.dart';
import 'package:dotw/constants/fonts.dart';
import 'package:dotw/entities/enemies/enemy.dart';
import 'package:dotw/entities/player.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../constants/colors.dart';

abstract class GameCard {
  static const double cardHeight = 132;
  static const double cardWidth = 85;

  final String title;
  final String description;
  final int cost;
  final int rarity;
  final String image;

  GameCard({
    required this.title,
    required this.description,
    required this.cost,
    required this.rarity,
    required this.image,
  });

  static RxList<GameCard> getCards(int amount) {
    var cards = List<GameCard>.empty().obs;
    while (cards.length < amount) {
      var randomCard = (listOfCards..shuffle()).first;
      cards.add(randomCard.call());
    }
    return cards;
  }

  Widget render() {
    Color color;
    String typeCard = '';
    if (this is OffensiveCard) {
      color = GameColors.red1;
      typeCard = 'Attack card';
    } else {
      color = Colors.blue;
      typeCard = 'Defence card';
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: color,
      ),
      height: GameCard.cardHeight,
      width: GameCard.cardWidth,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '$cost',
                    style: const TextStyle(
                      fontFamily: gillSans,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(3),
                  margin: const EdgeInsets.only(left: 5),
                  color: GameColors.pastel,
                  child: Text(
                    typeCard,
                    style: const TextStyle(fontSize: 10, fontFamily: gillSans),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              color: GameColors.pastel,
              child: Text(
                title,
                style: const TextStyle(fontSize: 7, fontFamily: gillSans),
              ),
            ),
            Container(
              color: Colors.white,
              width: 65,
              height: 36,
              padding: const EdgeInsets.all(3),
              child: Text(
                description,
                style: const TextStyle(fontSize: 6, fontFamily: gillSans),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void play(Player player, Enemy enemy) {
    player.usedCards.add(this);
  }
}
