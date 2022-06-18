import 'package:dotw/entities/enemies/enemy.dart';
import 'package:dotw/entities/enemies/move_set.dart';
import 'package:dotw/entities/entity.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ElevatedButtonEnemy extends Enemy {
  var face = '>:('.obs;

  ElevatedButtonEnemy()
      : super(
          name: 'Elevated Button',
          description: 'bla bla',
          hp: 2.obs,
          hpMax: 2,
          block: 0.obs,
          dmg: 1.obs,
          difficulty: 1,
          moveSet: [MoveSet.attack, MoveSet.block],
          blockMax: 0,
        ) {
    render = ElevatedButton(
      onPressed: () async {
        if (!isDead.value) {
          face.value = '>;)';
          await Future.delayed(const Duration(seconds: 1));
          face.value = '>:(';
        }
      },
      child: Obx(() => Text(face.value)),
    );
  }

  @override
  Future<void> onAttack(Entity attacker) async {
    super.onAttack(attacker);
    if (!isDead.value) {
      face.value = '<:O';
      await Future.delayed(const Duration(milliseconds: 500));
      face.value = '>:(';
    }
  }

  @override
  Future<void> onDeath(Entity attacker) async {
    super.onDeath(attacker);
    await Future.delayed(const Duration(milliseconds: 500));
    face.value = '>X(';
  }
}
