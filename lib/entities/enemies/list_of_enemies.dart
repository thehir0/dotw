import 'package:dotw/entities/enemies/circular_progress_indicator_enemy.dart';
import 'package:dotw/entities/enemies/container_enemy.dart';
import 'package:dotw/entities/enemies/elevated_button_enemy.dart';
import 'package:dotw/entities/enemies/icon_enemy.dart';
import 'package:dotw/entities/enemies/text_field_enemy.dart';

var listOfEnemies = [
  () => ElevatedButtonEnemy(),
  () => TextFieldEnemy(),
  () => ContainerEnemy(),
  () => CircularProgressIndicatorEnemy(),
  () => IconEnemy(),
];
