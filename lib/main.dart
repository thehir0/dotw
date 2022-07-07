import 'package:dotw/firebase_options.dart';
import 'package:dotw/user.dart';
import 'package:dotw/widgets/main_menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'localization/localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //name: 'dotw',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const MyApp());
}

bool hasInternetConnection = true;
RxBool logged = false.obs;
SignedUser? user;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var locale = const Locale('en').obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        translations: Languages(),
        locale: locale.value,
        debugShowCheckedModeBanner: false,
        title: 'DOTW',
        home: const MainMenu(),
        //theme: AppTheme.lightTheme,
        //darkTheme: AppTheme.darkTheme,
      ),
    );
  }
}
