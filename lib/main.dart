import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'entities/enemies/elevated_button_enemy.dart';
import 'entities/enemies/enemy.dart';
import 'entities/player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'qwerty',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Enemy q = ElevatedButtonEnemy();
  Player player = Player(
    name: 'Player',
    description: 'you',
    hp: 3.obs,
    hpMax: 3,
    dmg: 1.obs,
    block: 0.obs,
    energy: 3.obs,
    money: 0.obs,
  );
  var turn = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Obx(() => Text('${player.hp}/${player.hpMax}    ${player.money}')),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => Text('${q.hp}/${q.hpMax}')),
                q.render,
              ],
            ),
            ElevatedButton(
              onPressed: () {
                player.attack(q);
              },
              child: const Text('attack'),
            ),
          ],
        ),
      ),
    );
  }
}
