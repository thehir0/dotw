import 'package:dotw/cards/defensive_cards/gesturedetector_on_pan_update.dart';
import 'package:dotw/cards/offensive_cards/game_breaking_bug.dart';
import 'package:dotw/cards/offensive_cards/simple_click.dart';

import '../cards/defensive_cards/container_block.dart';
import '../cards/defensive_cards/dark_theme_card.dart';
import '../cards/defensive_cards/margin.dart';
import '../cards/defensive_cards/widget_test_card.dart';
import '../cards/offensive_cards/box_decoration.dart';
import '../cards/offensive_cards/flutter_web.dart';
import '../cards/offensive_cards/padding_attack.dart';
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
      Margin(),
      ContainerBlock(),
      GesturedetectorOnPanUpdate(),
      WidgetTestCard(),
      DarkThemeCard(),
      SimpleClick(),
      PaddingAttack(),
      BoxDecoration(),
      GameBreakingBug(),
      FlutterWeb(),
    ])).obs,
  );
}
