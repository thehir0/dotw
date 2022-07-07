import 'dart:math';

import 'package:dotw/entities/enemies/enemy.dart';
import 'package:dotw/entities/enemies/move_set.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../player.dart';

class IconEnemy extends Enemy {
  Rx<IconData> icon = Icons.abc.obs;
  List<IconData> accessibleIcons = [
    Icons.headphones,
    Icons.fork_left,
    Icons.baby_changing_station,
    Icons.error_outline,
    Icons.star_half
  ];

  IconEnemy()
      : super(
          name: 'Icon',
          description: 'bla bla',
          hp: 5.obs,
          hpMax: 5.obs,
          dmg: 3.obs,
          difficulty: 2,
          moveSet: [
            MoveSet.block,
            MoveSet.block,
            MoveSet.attack,
          ],
          blockMax: 3,
        ) {
    icon.value = getRandomIcon();
    render = SizedBox(
      height: 80,
      width: 160,
      child: Obx(
        () => Icon(
          icon.value,
          size: 100,
        ),
      ),
    );
  }

  @override
  void move(Player player, int turn) {
    icon.value = getRandomIcon();
    super.move(player, turn);
  }

  IconData getRandomIcon() {
    accessibleIcons.shuffle();
    return accessibleIcons[0];
  }
}
