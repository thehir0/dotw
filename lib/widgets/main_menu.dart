import 'package:dotw/Leaderboard.dart';
import 'package:dotw/Registration/login.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(
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
                'Play',
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
              'Leaderboard',
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
                  logged.value ? 'Log out' : 'Login',
                  style: GoogleFonts.vt323(
                      textStyle: const TextStyle(fontSize: 70)),
                ),
              ),
            )),
      ],
    );
  }
}