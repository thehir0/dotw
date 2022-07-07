import 'package:dotw/entities/enemies/enemy.dart';
import 'package:dotw/entities/enemies/move_set.dart';
import 'package:dotw/entities/entity.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class ElevatedButtonEnemy extends Enemy {
  var face = '>:('.obs;

  ElevatedButtonEnemy()
      : super(
          name: 'Elevated Button',
          description: 'bla bla',
          hp: 2.obs,
          hpMax: 2.obs,
          dmg: 1.obs,
          difficulty: 1,
          moveSet: [MoveSet.attack, MoveSet.block],
          blockMax: 1,
        ) {
    render = SizedBox(
      height: 80,
      width: 160,
      child: ElevatedButton(
        onPressed: () async {
          if (!isDead.value) {
            face.value = '>;)';
            await Future.delayed(const Duration(seconds: 1));
            face.value = '>:(';
          }
        },
        child: Obx(() => Text(
              face.value,
              style:
                  GoogleFonts.vt323(textStyle: const TextStyle(fontSize: 50)),
            )),
      ),
    );
  }

  @override
  Future<void> onAttack(Entity attacker) async {
    super.onAttack(attacker);
    if (!isDead.value) {
      face.value = '<:O';
      await Future.delayed(const Duration(milliseconds: 300));
      face.value = '>:(';
    }
  }

  @override
  Future<void> onDeath(Entity attacker) async {
    super.onDeath(attacker);
    await Future.delayed(const Duration(milliseconds: 300));
    face.value = '>X(';
  }
}
