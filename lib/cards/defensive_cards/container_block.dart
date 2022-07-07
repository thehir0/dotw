import 'package:dotw/cards/defensive_cards/defensive_cards.dart';

class ContainerBlock extends DefensiveCard {
  ContainerBlock()
      : super(
          title: 'Container Block',
          description: 'You block yourself with container! +2 armor',
          cost: 1,
          rarity: 2,
          image: "",
          block: 2,
        );
}
