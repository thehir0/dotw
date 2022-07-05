import 'registration.dart';
import '../constants/colors.dart';
import '../main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInScreen extends StatefulWidget {
  static const String route = '/login';

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
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (E) {
      message.value = E.message.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN'),
        centerTitle: true,
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
                      decoration: const InputDecoration(hintText: 'Nickname'),
                    ),
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
                  child: const Text("Login"),
                  onPressed: () {
                    signIn();
                  },
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RegistrationScreen.route);
                  },
                  child: const Text('CREATE NEW ACCOUNT')),
            ),
          ],
        ),
      ),
    ));
  }
}
