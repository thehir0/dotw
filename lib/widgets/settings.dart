import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
