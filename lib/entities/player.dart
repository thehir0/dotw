import 'package:dotw/cards/card.dart';
import 'package:dotw/entities/entity.dart';
import 'package:get/get.dart';

class Player extends Entity {
  Rx<int> energy;
  Rx<int> money;
  Rx<int> energyMax;
  RxList<GameCard> deck;

  Player({
    required super.name,
    required super.description,
    required super.hp,
    required super.hpMax,
    required super.dmg,
    required super.block,
    required this.energy,
    required this.money,
    required this.energyMax,
    required this.deck,
  });

  List<GameCard> getHand() {
    var hand = List<GameCard>.empty().obs;
    while (hand.length < 5) {
      var randomCard = (deck..shuffle()).first;
      if (!hand.contains(randomCard)) {
        hand.add(randomCard);
      }
    }
    return hand;
  }
}
