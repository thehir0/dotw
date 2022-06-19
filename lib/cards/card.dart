import 'package:dotw/entities/enemies/enemy.dart';
import 'package:dotw/entities/player.dart';
import 'package:flutter/cupertino.dart';

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

  Widget render();

  void play(Player player, Enemy enemy);
}
