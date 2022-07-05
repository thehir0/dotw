import 'package:dotw/cards/defensive_cards/defensive_cards.dart';
import 'package:dotw/cards/offensive_cards/offensive_card.dart';
import 'package:dotw/entities/enemies/enemy.dart';
import 'package:dotw/entities/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

abstract class GameCard {
  static const double cardHeight = 132;
  static const double cardWidth = 85;

  final String title;
  final String description;
  final int cost;

  GameCard({
    required this.title,
    required this.description,
    required this.cost,
  });

  Widget render(){
    Color color;
    String number;
    if(this is OffensiveCard){
      color = Colors.red;
      number = (this as OffensiveCard).dmg.toString();
    }
    else{
      color = Colors.blue;
      number = (this as DefensiveCard).block.toString();
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: color,
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
              number,
              style: GoogleFonts.vt323(
                  textStyle: const TextStyle(fontSize: 30),
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  void play(Player player, Enemy enemy);
}
