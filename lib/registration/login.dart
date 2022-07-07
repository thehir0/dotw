import 'package:dotw/constants/fonts.dart';
import 'package:dotw/user.dart';
import 'registration.dart';
import '../constants/colors.dart';
import '../main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => LogInScreenState();
}

class LogInScreenState extends State<LogInScreen> {
  var message = "".obs;
  final nicknameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nicknameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "${nicknameController.text.trim()}@gmail.com",
        password: passwordController.text.trim(),
      );

      if (FirebaseAuth.instance.currentUser != null) {
        logged.value = true;

        user = SignedUser(FirebaseAuth.instance.currentUser!.email!
            .toString()
            .replaceAll('@gmail.com', ''));

        Get.back();
      }
    } on FirebaseAuthException catch (E) {
      message.value = E.message.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColors.first,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Welcome back to'.tr,
                    style: const TextStyle(
                        fontFamily: gillSans,
                        fontSize: 14,
                        color: Colors.white),
                  )),
            ),
            const Flexible(
              flex: 1,
              child: Text(
                'DOTW',
                style: TextStyle(
                    fontFamily: beaufort, fontSize: 64, color: Colors.white),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: 256,
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Obx(
                  () => Text(
                    message.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: gillSans, fontSize: 14, color: Colors.red),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: 48,
                width: 256,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 3, color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                    controller: nicknameController,
                    decoration: InputDecoration.collapsed(
                        hintText: 'Username'.tr,
                        hintStyle: const TextStyle(
                            color: GameColors.black50,
                            fontFamily: gillSans,
                            fontSize: 14))),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: 48,
                width: 256,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 3, color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration.collapsed(
                        hintText: 'Password'.tr,
                        hintStyle: const TextStyle(
                            color: GameColors.black50,
                            fontFamily: gillSans,
                            fontSize: 14))),
              ),
            ),
            Flexible(
                flex: 1,
                child: Container(
                  width: 256,
                  height: 48,
                  margin: const EdgeInsets.only(top: 24),
                  decoration: const BoxDecoration(
                    gradient: Gradients.grad2,
                  ),
                  child: ElevatedButton(
                    onPressed: () => signIn(),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: Text(
                      'Login'.tr,
                      style: const TextStyle(
                          fontFamily: beaufort,
                          fontSize: 22,
                          color: Colors.white),
                    ),
                  ),
                )),
            Flexible(
                flex: 1,
                child: Container(
                  width: 256,
                  height: 48,
                  margin: const EdgeInsets.only(top: 24),
                  color: GameColors.second,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const RegistrationScreen()),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: Text(
                      'No account? Register now'.tr,
                      style: const TextStyle(
                          fontFamily: gillSans,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ),
                )),
            Flexible(
                flex: 1,
                child: TextButton(
                  child: Text(
                    'Back to game'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: gillSans,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                )),
          ],
        ),
      ),
    );
  }
}
