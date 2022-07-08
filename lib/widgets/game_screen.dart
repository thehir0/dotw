import 'package:confetti/confetti.dart';
import 'package:dotw/constants/create_player.dart';
import 'package:dotw/entities/enemies/move_set.dart';
import 'package:dotw/main.dart';
import 'package:dotw/widgets/app_bar.dart';
import 'package:dotw/widgets/shop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../cards/card.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
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
                            Obx(() => DragTarget<GameCard>(
                                  builder: (
                                    BuildContext context,
                                    List<dynamic> accepted,
                                    List<dynamic> rejected,
                                  ) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Obx(() => RichText(
                                              text: TextSpan(
                                                  text:
                                                      '[$index] ${currentEnemy.name} ',
                                                  style: GoogleFonts.vt323(
                                                      textStyle:
                                                          const TextStyle(
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
                                                          color:
                                                              Colors.redAccent),
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
                                                  if (currentEnemy
                                                          .getMove(turn) ==
                                                      MoveSet.attack) ...[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.umbrella_sharp,
                                                          size: 20,
                                                          color:
                                                              Colors.redAccent,
                                                        ),
                                                        Text(
                                                          '${currentEnemy.dmg}',
                                                          style: GoogleFonts.vt323(
                                                              textStyle:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          30),
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                      ],
                                                    ),
                                                  ] else if (currentEnemy
                                                          .getMove(turn) ==
                                                      MoveSet.block) ...[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                                      fontSize:
                                                                          30),
                                                              color:
                                                                  Colors.blue),
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
                                        currentEnemy.render,
                                      ],
                                    );
                                  },
                                  onAccept: (currentEnemy.isDead.isFalse
                                      ? (GameCard card) {
                                          if (player.energy.value >=
                                              card.cost) {
                                            card.play(player, enemies[index]);
                                            hand.remove(card);
                                            player.usedCards.add(card);
                                            player.energy.value -= card.cost;
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
                                          }
                                          user?.cardsPlayed.value++;
                                        }
                                      : (GameCard card) {}),
                                )),
                          ]);
                    },
                  )),
            ),
            Flexible(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 84,
                          height: 44,
                          decoration: BoxDecoration(
                              color: GameColors.second,
                              borderRadius: BorderRadius.circular(8),
                              gradient: Gradients.grad2),
                          child: ElevatedButton(
                            onPressed: () => showDeckDialog(context),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent),
                            child: Image.asset(
                              'assets/icon/cards.png',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          margin: const EdgeInsets.only(right: 15, left: 15),
                          child: Image.asset('assets/icon/energy.png'),
                        ),
                        Obx(() => Text(
                              '${player.energy.value}/${player.energyMax.value}',
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontFamily: beaufort,
                                  color: Colors.black87),
                            )),
                      ],
                    ),
                    Container(
                      width: 90,
                      height: 44,
                      decoration: BoxDecoration(
                          color: GameColors.second,
                          borderRadius: BorderRadius.circular(8),
                          gradient: Gradients.grad2),
                      child: ElevatedButton(
                        onPressed: () {
                          for (final enemy in enemies) {
                            enemy.move(player, turn);
                          }
                          if (player.isDead.isTrue) {
                            user?.died.value++;
                            showDeathDialog(context);
                          }
                          player.usedCards.addAll(hand);
                          hand.clear();
                          hand.addAll(player.getHand());
                          player.block.value = 0;
                          player.energy.value = player.energyMax.value;
                          turn++;
                          user?.turnsFinished.value++;
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent),
                        child: Text(
                          'Next turn'.tr,
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: beaufort,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 4,
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

  void updateRecord() {
    if (hasInternetConnection && logged.value) {
      user?.updateRecord(player.score.value);
    }
  }

  void showDeathDialog(BuildContext context) {
    updateRecord();
    final Widget closeButton = ElevatedButton(
      style: ElevatedButton.styleFrom(primary: GameColors.barColor),
      child: Text(
        'Exit to main menu'.tr,
        style: const TextStyle(
            fontSize: 14, fontFamily: beaufort, color: Colors.redAccent),
      ),
      onPressed: () {
        Get.back();
        Get.back();
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
                style: const TextStyle(
                    fontSize: 50,
                    fontFamily: beaufort,
                    color: Colors.redAccent),
              ),
              Text(
                '${'Score:'.tr}${player.score}',
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: beaufort,
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
    final controller = ConfettiController();
    controller.play();
    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            AlertDialog(
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
                            player.usedCards.addAll(hand);
                            hand.clear();
                            player.reassembleDeck();
                            hand.addAll(player.getHand());
                            enteredShop.value = false;
                            controller.stop();
                            Get.back();
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
                                          Get.to(
                                              Shop(player: player, room: room));
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
            ),
            ConfettiWidget(
              confettiController: controller,
              shouldLoop: true,
              blastDirectionality: BlastDirectionality.explosive,
            )
          ],
        );
      },
      barrierDismissible: false,
    );
  }
}
