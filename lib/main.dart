import 'package:dotw/firebase_options.dart';
import 'package:dotw/widgets/main_menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/state_manager.dart';
import 'constants/app_theme.dart';
import 'localization/localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

bool hasInternetConnection = true;
RxBool logged = false.obs;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var locale = const Locale('en').obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      translations: Languages(),
      locale: locale.value,
      title: 'DOTW',
      home: const MainMenu(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    ),);
  }
}

