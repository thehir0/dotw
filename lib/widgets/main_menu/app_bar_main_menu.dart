import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/colors.dart';
import '../../main.dart';
import '../settings.dart';

AppBar buildAppBarMainMenu(BuildContext context){
  return AppBar(
    backgroundColor: GameColors.barColor,
    automaticallyImplyLeading: false,
    elevation: 0,
    centerTitle: false,
    title: Row(
      children: [
        ElevatedButton(
            onPressed: (){
              Get.to(const Settings());
            },
            child: Text('Settings'.tr),
        ),
      ],
    )
  );
}