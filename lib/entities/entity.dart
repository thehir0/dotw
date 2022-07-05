import 'package:dotw/entities/player.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class Entity {
  final String name;
  final String description;
  Rx<int> hp;
  Rx<int> hpMax;
  Rx<int> dmg;
  Rx<int> block;
  late Widget render;
  var isDead = false.obs;

  Entity({
    required this.name,
    required this.description,
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
    final damage = (attacker.dmg.value - block.value);
    hp.value -= damage;
    if (attacker is Player) {
      attacker.score.value += damage;
    } else {
      (this as Player).score.value -= damage;
    }
    block.value = 0;
    if (hp <= 0) {
      onDeath(attacker);
    }
  }

  void onBlock(Entity attacker) {
    block.value -= attacker.dmg.value;
  }

  void onDeath(Entity attacker) {
    isDead.value = true;
    hp.value = 0;
  }
}
