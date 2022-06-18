import 'package:dotw/entities/entity.dart';
import 'package:get/get.dart';

class Player extends Entity {
  Rx<int> energy;
  Rx<int> money;

  Player({
    required super.name,
    required super.description,
    required super.hp,
    required super.hpMax,
    required super.dmg,
    required super.block,
    required this.energy,
    required this.money,
  });
}
