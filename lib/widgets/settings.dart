import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';

void settings(BuildContext context) {
  RxString dropdown = 'English'.obs;

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Center(
                child: Text(
              'Settings',
              style: TextStyle(
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
                      const Text(
                        'Choose Language:',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: gillSans,
                            color: Colors.white),
                      ),
                      Obx(() => Container(
                          width: 80,
                          height: 20,
                          margin: const EdgeInsets.only(left: 15),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          color: Colors.white,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownButton(
                                  dropdownColor: Colors.white,
                                  value: dropdown.value,
                                  underline: const SizedBox(),
                                  iconSize: 0.0,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    dropdown.value = newValue!;

                                    if (dropdown.value == 'English') {
                                      Get.updateLocale(
                                          const Locale('en').obs.value);
                                    } else {
                                      Get.updateLocale(
                                          const Locale('ru').obs.value);
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
                                const Icon(Icons.arrow_drop_down),
                              ]))),
                    ],
                  ),
                ],
              ),
            ));
      });
}
