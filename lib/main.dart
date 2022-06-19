import 'dart:async';

import 'package:dotw/Leaderboard.dart';
import 'package:dotw/cards/defensive_cards/basic_defense.dart';
import 'package:dotw/cards/offensive_cards/basic_attack.dart';
import 'package:dotw/entities/enemies/move_set.dart';
import 'package:dotw/entities/enemies/text_field_enemy.dart';
import 'package:dotw/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
// import 'package:show_more_text_popup/show_more_text_popup.dart';

import 'cards/card.dart';
import 'entities/enemies/enemy.dart';
import 'entities/player.dart';
import 'constants/colors.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DOTW',
      initialRoute: MainMenu.route,
      routes: {
        MainMenu.route: (context) => const MainMenu(),
        GameScreen.route: (context) => const GameScreen(),
        Leaderboard.route: (context) => const Leaderboard(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatefulWidget {
  static const String route = '';
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, GameScreen.route);
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
              },
              child: Text(
                'Play',
                style:
                    GoogleFonts.vt323(textStyle: const TextStyle(fontSize: 70)),
              ),
            )),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Leaderboard.route);
          },
          child: Text(
            'Leaderboard',
            style: GoogleFonts.vt323(textStyle: const TextStyle(fontSize: 70)),
          ),
        ),
      ],
    );
  }
}

class GameScreen extends StatefulWidget {
  static const String route = '/dotw';

  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Player player;

  late Enemy currentEnemy;
  late RxList<GameCard> hand;
  int turn = 0;

  @override
  initState() {
    super.initState();
    player = Player(
      energy: 5.obs,
      dmg: 1.obs,
      description: 'You',
      hpMax: 5.obs,
      money: 86.obs,
      hp: 5.obs,
      block: 0.obs,
      name: 'Player',
      energyMax: 5.obs,
      deck: (List<GameCard>.of([
        BasicAttack(),
        BasicAttack(),
        BasicAttack(),
        BasicDefense(),
        BasicDefense(),
        BasicDefense(),
      ])).obs,
    );
    hand = player.getHand().obs;
    currentEnemy = TextFieldEnemy();
  }

  int acceptedData = 0;

  @override
  Widget build(BuildContext context) {
    /*
      For description window
     */

    // ShowMoreTextPopup popup = ShowMoreTextPopup(context,
    //     text: '123',
    //     textStyle: const TextStyle(color: Colors.black),
    //     height: 200,
    //     width: 100,
    //     backgroundColor: const Color(0xFF16CCCC),
    //     padding: const EdgeInsets.all(4.0),
    //     borderRadius: BorderRadius.circular(10.0));

    double startPosition = -30.0.obs;
    return Scaffold(
        appBar: AppBar(
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
                    '${player.block.value}',
                    style: GoogleFonts.vt323(
                        textStyle: const TextStyle(fontSize: 30),
                        color: Colors.blue),
                  )),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 28,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => RichText(
                          text: TextSpan(
                              text: '${currentEnemy.name} ',
                              style: GoogleFonts.vt323(
                                  textStyle: const TextStyle(fontSize: 30),
                                  color: Colors.red),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      '[${currentEnemy.hp}/${currentEnemy.hpMax} ',
                                  style: GoogleFonts.vt323(
                                      textStyle: const TextStyle(fontSize: 30),
                                      color: Colors.redAccent),
                                ),
                                TextSpan(
                                  text:
                                      '${currentEnemy.block}/${currentEnemy.blockMax}]',
                                  style: GoogleFonts.vt323(
                                      textStyle: const TextStyle(fontSize: 30),
                                      color: Colors.blue),
                                ),
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (currentEnemy.getMove(turn) ==
                                MoveSet.attack) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                            const TextStyle(fontSize: 30),
                                        color: Colors.blue),
                                  ),
                                ],
                              ),
                            ] else if (currentEnemy.getMove(turn) ==
                                MoveSet.block) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                            const TextStyle(fontSize: 30),
                                        color: Colors.blue),
                                  ),
                                ],
                              )
                            ]
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DragTarget<GameCard>(
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        ) {
                          return currentEnemy.render;
                        },
                        onAccept: (GameCard card) {
                          if (player.energy.value >= card.cost) {
                            card.play(player, currentEnemy);
                            player.energy.value--;

                            int num = -1;
                            hand.firstWhere((element) {
                              num++;
                              return element == card;
                            });
                            hand.removeAt(num);
                          }
                        },
                      ),
                    ],
                  )),
              Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          player.energy.value = player.energyMax.value;
                          currentEnemy.move(player, turn);
                          player.block.value = 0;
                          turn++;
                          hand.value = player.getHand().obs;
                        },
                        child: Text(
                          'End turn',
                          style: GoogleFonts.vt323(
                              textStyle: const TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  )),
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
                        child: card.render(),
                      );
                    }).toList(),
                  );
                }),
              )
            ],
          ),
        ));
  }
}
