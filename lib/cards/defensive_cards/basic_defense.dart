import 'package:dotw/cards/defensive_cards/defensive_cards.dart';

class BasicDefense extends DefensiveCard {
  BasicDefense()
      : super(
          title: 'Wooden armor plate',
          description: 'Give 1 armor. Or not?',
          cost: 1,
          rarity: 1,
          block: 1,
        );
}
