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
  void play(Player player, Enemy enemy) {
    player.dmg.value = dmg;
    player.attack(enemy);
  }
}
