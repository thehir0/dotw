import 'dart:math';

import 'package:dotw/constants/create_player.dart';
import 'package:dotw/entities/enemies/move_set.dart';
import 'package:dotw/main.dart';
import 'package:dotw/widgets/app_bar.dart';
import 'package:dotw/widgets/shop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../cards/card.dart';
import '../constants/colors.dart';
import '../entities/enemies/enemy.dart';
import '../entities/player.dart';

class GameScreen extends StatefulWidget {
  static const String route = '/dotw';

  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Player player;
  late RxList<Enemy> enemies;
  late RxList<GameCard> hand;

  int turn = 0;
  int room = 1;
  RxBool enteredShop = false.obs;

  @override
  initState() {
    super.initState();
    player = buildStarterPlayer();
    hand = player.getHand().obs;
    enemies = Enemy.getEnemies(2);
  }

  @override
  Widget build(BuildContext context) {
    double startPosition = -30.0.obs;
    return Scaffold(
      appBar: buildAppBar(player),
      body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 15,
              child: Obx(() => GridView.builder(
                    itemCount: enemies.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemBuilder: (context, index) {
                      final currentEnemy = enemies[index];
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 28,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(() => RichText(
                                          text: TextSpan(
                                              text:
                                                  '[$index] ${currentEnemy.name} ',
                                              style: GoogleFonts.vt323(
                                                  textStyle: const TextStyle(
                                                      fontSize: 30),
                                                  color: Colors.red),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      '[${currentEnemy.hp}/${currentEnemy.hpMax}]',
                                                  style: GoogleFonts.vt323(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 30),
                                                      color: Colors.redAccent),
                                                ),
                                              ]),
                                        )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Obx(() => currentEnemy.isDead.isFalse
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (currentEnemy.getMove(turn) ==
                                                  MoveSet.attack) ...[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.umbrella_sharp,
                                                      size: 20,
                                                      color: Colors.redAccent,
                                                    ),
                                                    Text(
                                                      '${currentEnemy.dmg}',
                                                      style: GoogleFonts.vt323(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize: 30),
                                                          color: Colors.blue),
                                                    ),
                                                  ],
                                                ),
                                              ] else if (currentEnemy
                                                      .getMove(turn) ==
                                                  MoveSet.block) ...[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.shield,
                                                      size: 20,
                                                      color: Colors.blue,
                                                    ),
                                                    Text(
                                                      '${currentEnemy.block}',
                                                      style: GoogleFonts.vt323(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize: 30),
                                                          color: Colors.blue),
                                                    ),
                                                  ],
                                                )
                                              ]
                                            ],
                                          )
                                        : Text(
                                            '*dead*'.tr,
                                            style: GoogleFonts.vt323(
                                                textStyle: const TextStyle(
                                                    fontSize: 30),
                                                color: Colors.redAccent),
                                          )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Obx(() => currentEnemy.isDead.isFalse
                                        ? DragTarget<GameCard>(
                                            builder: (
                                              BuildContext context,
                                              List<dynamic> accepted,
                                              List<dynamic> rejected,
                                            ) {
                                              return currentEnemy.render;
                                            },
                                            onAccept: (GameCard card) {
                                              if (player.energy.value >=
                                                  card.cost) {
                                                card.play(
                                                    player, enemies[index]);
                                                player.energy.value -=
                                                    card.cost;
                                                bool victory = true;
                                                for (final enemy in enemies) {
                                                  if (enemy.isDead.isFalse) {
                                                    victory = false;
                                                    break;
                                                  }
                                                }
                                                if (victory) {
                                                  showYouWin(context);
                                                }

                                                hand.remove(card);
                                              }
                                            },
                                          )
                                        : currentEnemy.render)
                                  ],
                                )),
                          ]);
                    },
                  )),
            ),
            Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDeckDialog(context);
                      },
                      icon: const Icon(
                        Icons.book_sharp,
                        size: 40,
                      ),
                    ),
                  ],
                )),
            Flexible(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.flash_on_sharp,
                    size: 35,
                    color: GameColors.goldColor,
                  ),
                  Obx(() => Text(
                        '${player.energy.value}/${player.energyMax.value}',
                        style: GoogleFonts.vt323(
                            textStyle: const TextStyle(fontSize: 30),
                            color: GameColors.goldColor),
                      )),
                  ElevatedButton(
                    onPressed: () {
                      for (final enemy in enemies) {
                        enemy.move(player, turn);
                      }
                      if (player.isDead.isTrue) {
                        showDeathDialog(context);
                      }
                      player.block.value = 0;
                      player.energy.value = player.energyMax.value;
                      turn++;
                      hand.value = player.getHand().obs;
                    },
                    child: Text(
                      'End turn'.tr,
                      style: GoogleFonts.vt323(
                          textStyle: const TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 7,
              child: Obx(() {
                startPosition = 0;
                return Stack(
                  alignment: Alignment.center,
                  children: hand.map((card) {
                    startPosition += 50;
                    return Positioned(
                      left: startPosition,
                      child: Draggable<GameCard>(
                        childWhenDragging: Container(),
                        data: card,
                        feedback: card.render(),
                        child: card.render(),
                      ),
                    );
                  }).toList(),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  void updateScore() async {
    if (hasInternetConnection && FirebaseAuth.instance.currentUser != null) {
      String? username = FirebaseAuth.instance.currentUser?.email.toString();
      int? len = username?.length;
      username = username?.substring(0, len! - 10);

      var href = FirebaseDatabase.instance.ref('scores');
      final snapshot = await href.child(username!).get();

      int score = player.score.value;

      if (snapshot.exists) {
        score = max(score, snapshot.value as int);
      }

      href.update({username: score});
    }
  }

  void showDeathDialog(BuildContext context) {
    updateScore();
    final Widget closeButton = ElevatedButton(
      style: ElevatedButton.styleFrom(primary: GameColors.barColor),
      child: Text(
        'Exit to main menu'.tr,
        style: GoogleFonts.vt323(
            textStyle: const TextStyle(fontSize: 30), color: Colors.redAccent),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    final AlertDialog alert = AlertDialog(
      backgroundColor: Colors.black54,
      elevation: 0,
      content: SizedBox(
          height: 120,
          width: 400,
          child: Column(
            children: [
              Text(
                'You DIED'.tr,
                style: GoogleFonts.vt323(
                    textStyle: const TextStyle(fontSize: 50),
                    color: Colors.redAccent),
              ),
              Text(
                '${'Score:'.tr}${player.score}',
                style: GoogleFonts.vt323(
                    textStyle: const TextStyle(fontSize: 20),
                    color: Colors.redAccent),
              ),
              closeButton,
            ],
          )),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
      barrierDismissible: false,
    );
  }

  void showDeckDialog(BuildContext context) {
    final AlertDialog alert = AlertDialog(
      backgroundColor: Colors.black54,
      elevation: 0,
      content: SizedBox(
        height: 155,
        width: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(4.0),
          children: <Widget>[
            if (player.deck.isNotEmpty)
              for (GameCard card in player.deck) buildDeck(card, context),
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget buildDeck(GameCard card, BuildContext context) {
    return card.render();
  }

  void showYouWin(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          elevation: 0,
          content: SizedBox(
            height: 120,
            width: 400,
            child: Column(
              children: [
                Text(
                  '${'Score:'.tr}${player.score}',
                  style: GoogleFonts.vt323(
                      textStyle: const TextStyle(fontSize: 20),
                      color: const Color.fromARGB(255, 147, 131, 251)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        enemies.clear();
                        enemies.addAll(Enemy.getEnemies(2));
                        player.block.value = 0;
                        player.energy.value = player.energyMax.value;
                        turn = 0;
                        room++;
                        player.reassembleDeck();
                        hand.value = player.getHand();
                        enteredShop.value = false;
                        Navigator.of(context).pop();
                      },
                      child: Text('Continue'.tr),
                    ),
                    room % 5 == 0
                        ? Obx(
                            () => ElevatedButton(
                              onPressed: !enteredShop.isFalse
                                  ? null
                                  : () {
                                      enteredShop.value = true;
                                      Get.to(Shop(player: player, room: room));
                                    },
                              child: const Text('Shop'),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      barrierDismissible: false,
    );
  }
}
