import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotw/constants/colors.dart';
import 'package:dotw/constants/fonts.dart';
import 'package:dotw/entities/enemies/circular_progress_indicator_enemy.dart';
import 'package:dotw/entities/enemies/container_enemy.dart';
import 'package:dotw/entities/enemies/elevated_button_enemy.dart';
import 'package:dotw/entities/enemies/icon_enemy.dart';
import 'package:dotw/entities/enemies/text_field_enemy.dart';
import 'package:dotw/widgets/main_menu/app_bar_main_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../cards/defensive_cards/margin.dart';
import '../cards/defensive_cards/widget_test_card.dart';
import '../cards/offensive_cards/flutter_web.dart';
import '../cards/offensive_cards/simple_click.dart';
import 'game_screen.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool hasInternetConnection = true;
  late StreamSubscription<ConnectivityResult> networkSubscription;

  @override
  void initState() {
    networkSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        hasInternetConnection = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'No Internet Connection! Your progress won\'t be saved'.tr),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        hasInternetConnection = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reconnected to the Internet'.tr),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    networkSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: buildAppBarMainMenu(context),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 256,
                height: 80,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: GameColors.second,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(const GameScreen());
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: Text(
                    'Play!'.tr,
                    style: const TextStyle(
                        fontFamily: beaufort,
                        fontSize: 45,
                        color: Colors.white),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 84,
                    height: 44,
                    decoration: BoxDecoration(
                      color: GameColors.second,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton(
                      key: const ValueKey('DeckButton'),
                      onPressed: () {
                        showDeckDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: Image.asset(
                        'assets/icon/cards.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: null,
                  ),
                  Container(
                    width: 84,
                    height: 44,
                    decoration: BoxDecoration(
                      color: GameColors.second,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton(
                      key: const ValueKey('EnemiesButton'),
                      onPressed: () {
                        showEnemiesDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: Image.asset(
                        'assets/icon/encycloped.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void showDeckDialog(BuildContext context) {
    final AlertDialog alert = AlertDialog(
      key: const ValueKey('DeckDialog'),
      backgroundColor: Colors.black54,
      elevation: 0,
      content: SizedBox(
        height: 155,
        width: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(4.0),
          children: <Widget>[
            Margin().render(),
            const SizedBox(width: 10),
            Margin().render(),
            const SizedBox(width: 10),
            Margin().render(),
            const SizedBox(width: 10),
            WidgetTestCard().render(),
            const SizedBox(width: 10),
            WidgetTestCard().render(),
            const SizedBox(width: 10),
            SimpleClick().render(),
            const SizedBox(width: 10),
            SimpleClick().render(),
            const SizedBox(width: 10),
            SimpleClick().render(),
            const SizedBox(width: 10),
            FlutterWeb().render(),
            const SizedBox(width: 10),
            FlutterWeb().render(),
            const SizedBox(width: 10),
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

  void showEnemiesDialog(BuildContext context) {
    final AlertDialog alert = AlertDialog(
      key: const ValueKey('EnemiesDialog'),
      backgroundColor: Colors.white,
      elevation: 0,
      content: SizedBox(
        height: 120,
        width: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(4.0),
          children: <Widget>[
            Column(
              children: [
                const Text('Icon Enemy'),
                IconEnemy().render,
              ],
            ),
            Column(
              children: [
                const Text('CPI Enemy'),
                CircularProgressIndicatorEnemy().render,
              ],
            ),
            const SizedBox(width: 15),
            Column(
              children: [
                const Text('Container Enemy'),
                ContainerEnemy().render,
              ],
            ),
            const SizedBox(width: 15),
            Column(
              children: [
                const Text('Elevated Button Enemy'),
                ElevatedButtonEnemy().render,
              ],
            ),
            const SizedBox(width: 15),
            Column(
              children: [
                const Text('Text Field Enemy'),
                TextFieldEnemy().render,
              ],
            ),
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
}
