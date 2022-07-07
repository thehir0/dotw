import 'package:dotw/cards/offensive_cards/offensive_card.dart';

class BoxDecoration extends OffensiveCard {
  BoxDecoration()
      : super(
          title: 'Box Decoration',
          description:
              'You box the decoration out of this widget dealing 5 damage',
          cost: 3,
          rarity: 3,
          image: "",
          dmg: 5,
        );
}
