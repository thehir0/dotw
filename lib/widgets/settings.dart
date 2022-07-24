import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../main.dart';

void settings(BuildContext context) {
  late RxString dropdown;

  if (locale.value == const Locale('en')) {
    dropdown = 'English'.obs;
  } else {
    dropdown = 'Russia'.obs;
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Center(
                child: Text(
              'Settings'.tr,
              style: const TextStyle(
                  fontSize: 22, fontFamily: beaufort, color: Colors.white),
            )),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            backgroundColor: GameColors.first,
            content: SizedBox(
              width: 207,
              height: 280,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Choose Language:'.tr,
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: gillSans,
                            color: Colors.white),
                      ),
                      Container(
                          width: 80,
                          height: 20,
                          margin: const EdgeInsets.only(left: 15),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          color: Colors.white,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => DropdownButton(
                                    dropdownColor: Colors.white,
                                    value: dropdown.value,
                                    underline: const SizedBox(),
                                    iconSize: 0.0,
                                    style: const TextStyle(color: Colors.black),
                                    onChanged: (String? newValue) {
                                      dropdown.value = newValue!;

                                      if (dropdown.value == 'English') {
                                        locale = const Locale('en').obs;
                                        Get.updateLocale(locale.value);
                                      } else {
                                        locale = const Locale('ru').obs;

                                        Get.updateLocale(locale.value);
                                      }
                                    },
                                    items: <String>['English', 'Russia']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Center(child: Text(value)),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ])),
                    ],
                  ),
                ],
              ),
            ));
      });
}
