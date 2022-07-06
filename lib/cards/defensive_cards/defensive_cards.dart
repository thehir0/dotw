import 'package:dotw/cards/card.dart';
import 'package:dotw/entities/enemies/enemy.dart';
import 'package:dotw/entities/player.dart';

class DefensiveCard extends GameCard {
  final int block;

  DefensiveCard({
    required super.title,
    required super.description,
    required super.cost,
    required super.rarity,
    required this.block,
  });

  @override
  void play(Player player, Enemy enemy) {
    player.block.value += block;
  }
}
