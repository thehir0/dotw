import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../entities/player.dart';

AppBar buildAppBar(Player player){
  return AppBar(
    backgroundColor: GameColors.barColor,
    automaticallyImplyLeading: false,
    elevation: 0,
    centerTitle: false,
    title: Row(
      children: [
        const Icon(
          Icons.favorite,
          size: 40,
          color: Colors.redAccent,
        ),
        const SizedBox(
          width: 5,
        ),
        Obx(() => Text(
          '${player.hp.value}/${player.hpMax}',
          style: GoogleFonts.vt323(
              textStyle: const TextStyle(fontSize: 30),
              color: Colors.redAccent),
        )),
        const SizedBox(
          width: 30,
        ),
        const Icon(
          Icons.attach_money_sharp,
          size: 35,
          color: Colors.green,
        ),
        Obx(() => Text(
          '${player.money.value}',
          style: GoogleFonts.vt323(
              textStyle: const TextStyle(fontSize: 30),
              color: Colors.green),
        )),
        const SizedBox(
          width: 30,
        ),
        const Icon(
          Icons.shield,
          size: 35,
          color: Colors.blue,
        ),
        Obx(() => Text(
          '${player.block}',
          style: GoogleFonts.vt323(
            textStyle: const TextStyle(fontSize: 30),
            color: Colors.blue,
          ),
        )),
      ],
    ),
  );
}