import 'package:dotw/cards/card.dart';
import 'package:dotw/entities/entity.dart';
import 'package:get/get.dart';

class Player extends Entity {
  Rx<int> energy;
  Rx<int> money;
  Rx<int> energyMax;
  Rx<int> handSize;
  RxList<GameCard> deck;
  List<GameCard> usedCards = [];
  Rx<int> score = 0.obs;

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
    required this.handSize,
    required this.deck,
  });

  void reassembleDeck() {
    deck.addAll(usedCards);
    usedCards.clear();
  }

  List<GameCard> getHand() {
    var hand = List<GameCard>.empty().obs;
    while (hand.length < handSize.value) {
      if (deck.isEmpty) {
        deck.addAll(usedCards);
        usedCards.clear();
      }
      var randomCard = (deck..shuffle()).first;
      deck.remove(randomCard);
      usedCards.add(randomCard);
      hand.add(randomCard);
    }
    return hand;
  }
}
