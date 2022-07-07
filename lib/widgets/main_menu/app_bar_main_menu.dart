import 'package:dotw/constants/fonts.dart';
import 'package:dotw/registration/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../main.dart';
import '../leaderboard.dart';
import '../settings.dart';

AppBar buildAppBarMainMenu(BuildContext context) {
  return AppBar(
    backgroundColor: GameColors.first,
    automaticallyImplyLeading: false,
    elevation: 0,
    centerTitle: false,
    title: const LeftAppBar(),
    actions: [
      IconButton(
          onPressed: () => Get.to(const Leaderboard()),
          icon: Image.asset(
            'assets/icon/podium.png',
            color: Colors.white,
          )),
      IconButton(
          onPressed: () {
            Get.to(const Settings());
          },
          icon: Image.asset(
            'assets/icon/settings.png',
            color: Colors.white,
          )),
    ],
  );
}

class LeftAppBar extends StatefulWidget {
  const LeftAppBar({Key? key}) : super(key: key);

  @override
  State<LeftAppBar> createState() => LeftAppBarState();
}

class LeftAppBarState extends State<LeftAppBar> {
  Widget loggedAppBar(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: const Center(
                        child: Text(
                      'Profile',
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: beaufort,
                          color: Colors.white),
                    )),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    backgroundColor: GameColors.first,
                    content: SizedBox(
                      width: 207,
                      height: 280,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Flexible(
                            flex: 1,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 32,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 14),
                                child: Center(
                                    child: Text('Set your profile picture',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 9))),
                              ),
                            ),
                          ),
                          Obx(
                            () => Flexible(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  user!.username.value,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: gillSans,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                          const Flexible(
                            flex: 1,
                            child: Text(
                              'Your Stats:',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: gillSans,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(
                              height: 69,
                              width: 175,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Record: ${user!.record.value}',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 8,
                                            fontFamily: gillSans),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: 80,
                              height: 24,
                              margin: const EdgeInsets.only(top: 20),
                              color: GameColors.second,
                              child: ElevatedButton(
                                onPressed: () {
                                  logged.value = !logged.value;
                                  FirebaseAuth.instance.signOut();
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent,
                                    shadowColor: Colors.transparent),
                                child: Text(
                                  'Log out'.tr,
                                  style: const TextStyle(
                                      fontFamily: gillSans, fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              });
        },
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 16,
              ),
            ),
            Column(
              children: [
                Obx(
                  () => Text(
                    user!.username.value,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: gillSans,
                        fontSize: 14),
                  ),
                ),
                Obx(() => Text(
                      'High score: ${user?.record}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: gillSans,
                          fontSize: 14),
                    )),
              ],
            ),
          ],
        ));
  }

  Widget unLoggedAppBar() {
    return TextButton(
        onPressed: () => Get.to(const LogInScreen()),
        child: const Text(
          'Login',
          style: TextStyle(
              fontFamily: beaufort, color: Colors.white, fontSize: 32),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => logged.value ? loggedAppBar(context) : unLoggedAppBar());
  }
}
