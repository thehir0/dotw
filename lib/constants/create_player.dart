import 'package:dotw/cards/defensive_cards/margin.dart';
import 'package:dotw/cards/defensive_cards/widget_test_card.dart';
import 'package:dotw/cards/offensive_cards/flutter_web.dart';
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
    energyMax: 5.obs,
    handSize: 5.obs,
    deck: (List<GameCard>.of([
      Margin(),
      Margin(),
      Margin(),
      WidgetTestCard(),
      WidgetTestCard(),
      SimpleClick(),
      SimpleClick(),
      SimpleClick(),
      FlutterWeb(),
      FlutterWeb(),
    ])).obs,
  );
}
