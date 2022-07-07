import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotw/registration/login.dart';
import 'package:dotw/widgets/leaderboard.dart';
import 'package:dotw/widgets/main_menu/app_bar_main_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import 'game_screen.dart';

class MainMenu extends StatefulWidget {
  static const String route = '';

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
            content:
                Text('No Internet Connection! Your progress won\'t be saved'.tr),
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
      appBar: buildAppBarMainMenu(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(const GameScreen());
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
                  },
                  child: Text(
                    'Play'.tr,
                    style:
                    GoogleFonts.vt323(textStyle: const TextStyle(fontSize: 70)),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(const Leaderboard());
                },
                child: Text(
                  'Leaderboard'.tr,
                  style:
                  GoogleFonts.vt323(textStyle: const TextStyle(fontSize: 70)),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Obx(
                      () => ElevatedButton(
                    onPressed: () {
                      if (logged.isFalse) {
                        Get.to(const LogInScreen());
                      } else {
                        setState(() {
                          logged.value = !logged.value;
                          FirebaseAuth.instance.signOut();
                        });
                      }
                    },
                    child: Text(
                      logged.value ? 'Log out'.tr : 'Login'.tr,
                      style: GoogleFonts.vt323(
                          textStyle: const TextStyle(fontSize: 70)),
                    ),
                  ),
                )),
          ],
        ),
      )
    );
  }
}
