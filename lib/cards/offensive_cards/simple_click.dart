import 'package:dotw/cards/offensive_cards/offensive_card.dart';

class SimpleClick extends OffensiveCard {
  SimpleClick()
      : super(
          title: 'Simple Click',
          description:
              'You simply click on the widget. Deals 1 damage. It ain\'t much but it\'s honest work',
          cost: 1,
          rarity: 1,
          image: "",
          dmg: 1,
        );
}
