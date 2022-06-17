import 'package:dotw/entities/enemies/move_set.dart';
import 'package:dotw/entities/entity.dart';
import 'package:dotw/entities/player.dart';

class Enemy extends Entity {
  List<MoveSet> moveSet;
  int difficulty;

  Enemy({
    required super.hp,
    required super.hpMax,
    required super.dmg,
    required super.block,
    required this.moveSet,
    required this.difficulty,
  });

  MoveSet getMove(int turn) {
    return moveSet[turn % moveSet.length];
  }

  @override
  void onDeath(Entity attacker) {
    if (attacker.runtimeType == Player && !isDead.value) {
      (attacker as Player).money.value += difficulty * 5;
    }
    super.onDeath(attacker);
  }
}
