import 'package:get/get.dart';

import '../constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class RegistrationScreen extends StatefulWidget {
  static const String route = '/registration';
  const RegistrationScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  var message = "".obs;

  final nicknameController = TextEditingController();
  final passwordController = TextEditingController();

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "${nicknameController.text.trim()}@gmail.com",
        password: passwordController.text.trim(),
      );
      if (FirebaseAuth.instance.currentUser != null) {
        logged.value = true;
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (E) {
      message.value = E.message.toString();
    }
  }

  @override
  void dispose() {
    nicknameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: Text(
                  'Defence of the Widgets',
                  style: GoogleFonts.vt323(
                    textStyle: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(bottom: 40),
                width: 200,
                height: 200,
                child: Image.asset(
                  'assets/icon/dotwIcon.png',
                  color: GameColors.barColor,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: 200,
                margin: const EdgeInsets.only(bottom: 25),
                child: Obx(
                  () => Text(
                    message.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.account_circle_rounded,
                    color: Colors.grey,
                  ),
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(left: 10),
                    child: TextField(
                        controller: nicknameController,
                        decoration:
                            const InputDecoration(hintText: 'Nickname')),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.lock_open_rounded,
                    color: Colors.grey,
                  ),
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                width: 200,
                height: 40,
                margin: const EdgeInsets.only(top: 60, bottom: 20),
                child: ElevatedButton(
                  child: const Text("Create Account"),
                  onPressed: () => signUp(),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
