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

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.updateLocale(const Locale('ru').obs.value);
              } ,
              child: const Text('Russian'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.updateLocale(const Locale('en').obs.value);
              } ,
              child: const Text('English'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.updateLocale(const Locale('ja').obs.value);
              } ,
              child: const Text('Japanese'),
            ),
          ],
        )
      ),
    );
  }
}
