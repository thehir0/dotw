import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'entities/enemies/elevated_button_enemy.dart';
import 'entities/enemies/enemy.dart';
import 'entities/player.dart';
import 'constants/colors.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotw/widgets/cards.dart';

void main() {
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
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, GameScreen.route);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
      },
      child: Text(
        'Play',
        style: GoogleFonts.vt323(textStyle: const TextStyle(fontSize: 70)),
      ),
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
  List<GameCard> allGameCards = [
    const AttackCard(),
    const DefenceCard(),
    const AttackCard(),
    const DefenceCard(),
  ];
  int acceptedData = 0;

  @override
  Widget build(BuildContext context) {
    double startPosition = -30;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: GameColors.barColor,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 14,
                child: DragTarget<int>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Container(
                      color: Colors.cyan,
                      child: Center(
                        child: Text('Value is updated $acceptedData',
                            style: GoogleFonts.vt323(
                                textStyle: const TextStyle(fontSize: 40))),
                      ),
                    );
                  },
                  onAccept: (int data) {
                    setState(() {
                      acceptedData += data;
                    });
                  },
                ),
              ),
              Flexible(
                flex: 3,
                child: Stack(
                  alignment: Alignment.center,
                  children: allGameCards.map((e) {
                    setState(() {
                      startPosition += 60;
                    });
                    return Positioned(
                      left: startPosition,
                      child: e,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ));
  }
}
