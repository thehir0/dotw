import 'package:dotw/cards/defensive_cards/container_block.dart';
import 'package:dotw/cards/defensive_cards/dark_theme_card.dart';
import 'package:dotw/cards/defensive_cards/gesturedetector_on_pan_update.dart';
import 'package:dotw/cards/defensive_cards/margin.dart';
import 'package:dotw/cards/defensive_cards/widget_test_card.dart';
import 'package:dotw/cards/offensive_cards/box_decoration.dart';
import 'package:dotw/cards/offensive_cards/flutter_web.dart';
import 'package:dotw/cards/offensive_cards/game_breaking_bug.dart';
import 'package:dotw/cards/offensive_cards/padding_attack.dart';
import 'package:dotw/cards/offensive_cards/simple_click.dart';

var listOfCards = [
  // Defense cards
  () => Margin(),
  () => ContainerBlock(),
  () => GesturedetectorOnPanUpdate(),
  () => WidgetTestCard(),
  () => DarkThemeCard(),

  // Attack cards
  () => SimpleClick(),
  () => PaddingAttack(),
  () => BoxDecoration(),
  () => GameBreakingBug(),
  () => FlutterWeb(),
];
