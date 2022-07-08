import 'package:dotw/cards/defensive_cards/gesturedetector_on_pan_update.dart';
import 'package:dotw/cards/offensive_cards/game_breaking_bug.dart';
import 'package:dotw/cards/offensive_cards/simple_click.dart';

import '../entities/player.dart';
import 'package:get/state_manager.dart';
import '../cards/card.dart';

Player buildStarterPlayer() {
  return Player(
    energy: 3.obs,
    dmg: 1.obs,
    description: 'You',
    hpMax: 5.obs,
    money: 0.obs,
    hp: 5.obs,
    block: 0.obs,
    name: 'Player',
    energyMax: 3.obs,
    handSize: 5.obs,
    deck: (List<GameCard>.of([
      GesturedetectorOnPanUpdate(),
      SimpleClick(),
      GameBreakingBug(),
      GameBreakingBug(),
      GameBreakingBug(),
      GameBreakingBug(),
    ])).obs,
  );
}
