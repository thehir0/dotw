import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotw/constants/colors.dart';
import 'package:dotw/constants/fonts.dart';
import 'package:dotw/widgets/main_menu/app_bar_main_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
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
                      onPressed: () {},
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
                      onPressed: () {},
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
}
