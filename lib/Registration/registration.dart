import 'package:dotw/registration/login.dart';
import 'package:dotw/widgets/main_menu.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class RegistrationScreen extends StatefulWidget {
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: Gradients.grad2_2,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(
                flex: 1,
                child: Text(
                  'Registration',
                  style: TextStyle(
                      fontFamily: 'Beaufort',
                      fontSize: 45,
                      color: Colors.white),
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
                          fontFamily: 'GillSansMTPRO',
                          fontSize: 14,
                          color: Colors.red),
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
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Username',
                          hintStyle: TextStyle(
                              color: GameColors.black50,
                              fontFamily: 'GillSansMTPRO',
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
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                              color: GameColors.black50,
                              fontFamily: 'GillSansMTPRO',
                              fontSize: 14))),
                ),
              ),
              Flexible(
                  flex: 1,
                  child: Container(
                    width: 256,
                    height: 48,
                    margin: const EdgeInsets.only(top: 24),
                    color: GameColors.second,
                    child: ElevatedButton(
                      onPressed: () => signUp(),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            fontFamily: 'Beaufort',
                            fontSize: 22,
                            color: Colors.white),
                      ),
                    ),
                  )),
              Flexible(
                  flex: 1,
                  child: TextButton(
                    child: const Text(
                      'Back to Login page',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'GillSansMTPRO',
                      ),
                    ),
                    onPressed: () {
                      Get.to(const LogInScreen());
                    },
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
