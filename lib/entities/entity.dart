import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'player.dart';

class Entity {
  Rx<int> hp;
  Rx<int> hpMax;
  Rx<int> dmg;
  Rx<int> block;
  late Widget render;
  var isDead = false.obs;

  Entity({
    required this.hp,
    required this.hpMax,
    required this.dmg,
    required this.block,
  });

  void attack(Entity entity) {
    if (isDead.value) return;
    final willAttack = (dmg.value - entity.block.value > 0);
    if (willAttack) {
      entity.onAttack(this);
    } else {
      entity.onBlock(this);
    }
  }

  void onAttack(Entity attacker) {
    hp.value -= (attacker.dmg.value - block.value);
    block = 0.obs;
    if (hp <= 0) {
      onDeath(attacker);
    }
  }

  void onBlock(Entity attacker) {
    block.value -= attacker.dmg.value;
  }

  void onDeath(Entity attacker) {
    isDead = true.obs;
    hp = 0.obs;
  }
}
