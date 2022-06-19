import 'package:dotw/cards/offensive_cards/offensive_card.dart';

class BasicAttack extends OffensiveCard {
  BasicAttack()
      : super(
            title: 'Sword Swing',
            cost: 1,
            dmg: 1,
            description: 'You swing your sword. Or not?');
}
