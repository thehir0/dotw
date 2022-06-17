import 'package:dotw/entities/enemies/enemy.dart';
import 'package:dotw/entities/player.dart';
import 'package:flutter/cupertino.dart';

class GameCard {
  final String title;
  final String description;
  final int cost;
  late Widget render;

  GameCard({
    required this.title,
    required this.description,
    required this.cost,
  });

  void play(Player player, Enemy enemy) {}
}
