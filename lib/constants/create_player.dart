import 'package:dotw/cards/offensive_cards/simple_click.dart';

import '../entities/player.dart';
import 'package:get/state_manager.dart';
import '../cards/card.dart';

Player buildStarterPlayer() {
  return Player(
    energy: 5.obs,
    dmg: 1.obs,
    description: 'You',
    hpMax: 5.obs,
    money: 0.obs,
    hp: 5.obs,
    block: 0.obs,
    name: 'Player',
    energyMax: 5.obs,
    handSize: 3.obs,
    deck: (List<GameCard>.of([
      SimpleClick(),
    ])).obs,
  );
}
