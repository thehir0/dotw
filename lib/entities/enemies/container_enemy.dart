import 'dart:math';

import 'package:dotw/entities/enemies/enemy.dart';
import 'package:dotw/entities/enemies/move_set.dart';
import 'package:dotw/entities/entity.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ContainerEnemy extends Enemy {
  var color = Colors.black.obs;
  var height = 80.0.obs;
  var width = 160.0.obs;
  var rng = Random();

  ContainerEnemy()
      : super(
          name: 'Container',
          description: 'bla bla',
          hp: 5.obs,
          hpMax: 5.obs,
          dmg: 3.obs,
          difficulty: 2,
          moveSet: [
            MoveSet.block,
            MoveSet.block,
            MoveSet.attack,
            MoveSet.attack
          ],
          blockMax: 3,
        ) {
    color.value = getRandomColor();
    height.value = 80;
    width.value = 160;
    render = Obx(
      () => AnimatedContainer(
        height: height.value,
        width: width.value,
        color: color.value,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  void onAttack(Entity attacker) {
    color.value = getRandomColor();
    height.value = rng.nextInt(40) + 40;
    width.value = rng.nextInt(80) + 80;
    super.onAttack(attacker);
  }

  Color getRandomColor() {
    return Color.fromRGBO(
        rng.nextInt(256), rng.nextInt(256), rng.nextInt(256), 1);
  }
}
