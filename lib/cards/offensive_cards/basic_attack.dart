import 'package:dotw/cards/offensive_cards/offensive_card.dart';

class BasicAttack extends OffensiveCard {
  BasicAttack()
      : super(
          title: 'Sword Swing',
          description: 'You swing your sword. Or not?',
          cost: 1,
          rarity: 1,
          image: "",
          dmg: 1,
        );
}
