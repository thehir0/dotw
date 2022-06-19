import 'package:dotw/entities/enemies/enemy.dart';
import 'package:dotw/entities/enemies/move_set.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldEnemy extends Enemy {
  TextFieldEnemy()
      : super(
          name: 'Text Field',
          description: 'bla bla bla',
          hp: 10.obs,
          hpMax: 10.obs,
          dmg: 2.obs,
          difficulty: 2,
          moveSet: [MoveSet.attack, MoveSet.attack, MoveSet.block],
          blockMax: 3,
        ) {
    render = SizedBox(
      height: 80,
      width: 160,
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'hi',
          labelStyle: GoogleFonts.vt323(
            textStyle: const TextStyle(
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}
