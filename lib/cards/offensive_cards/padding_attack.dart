import 'package:dotw/cards/offensive_cards/offensive_card.dart';

class PaddingAttack extends OffensiveCard {
  PaddingAttack()
      : super(
          title: 'Padding Attack',
          description: 'You squeeze enemy widget dealing 2 damage!',
          cost: 1,
          rarity: 2,
          image: "",
          dmg: 2,
        );
}
