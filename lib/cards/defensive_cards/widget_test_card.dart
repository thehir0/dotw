import 'package:dotw/cards/defensive_cards/defensive_cards.dart';

class WidgetTestCard extends DefensiveCard {
  WidgetTestCard()
      : super(
          title: 'Widget Test',
          description: 'Takes so much energy to code. Is it even worth it?',
          cost: 3,
          rarity: 2,
          image: "",
          block: 2,
        );
}
