import 'package:dotw/entities/enemies/enemy.dart';
import 'package:dotw/entities/enemies/move_set.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class CircularProgressIndicatorEnemy extends Enemy {
  var color = Colors.black.obs;

  CircularProgressIndicatorEnemy()
      : super(
          name: 'Circular Progress Indicator',
          description: 'bla bla',
          hp: 10.obs,
          hpMax: 10.obs,
          dmg: 2.obs,
          difficulty: 2,
          moveSet: [
            MoveSet.attack,
          ],
          blockMax: 0,
        ) {
    render = SizedBox(
      height: 80,
      width: 80,
      child: Obx(
        () => CircularProgressIndicator(
          value: hp.value / hpMax.value,
          color: Colors.blue,
        ),
      ),
    );
  }
}
