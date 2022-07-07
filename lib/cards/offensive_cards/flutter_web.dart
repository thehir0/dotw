import 'package:dotw/cards/offensive_cards/offensive_card.dart';

class FlutterWeb extends OffensiveCard {
  FlutterWeb()
      : super(
          title: 'Flutter Web',
          description: 'Enemy tries to use it and gets hurt. Deals 3 damage',
          cost: 2,
          rarity: 2,
          image: "",
          dmg: 3,
        );
}
