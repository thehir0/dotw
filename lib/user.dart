import 'dart:math';
import 'package:dotw/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class SignedUser {
  late RxString username;
  RxInt record = 0.obs;
  RxInt moneySpent = 0.obs;
  RxInt turnsFinished = 0.obs;
  RxInt enemiesKilled = 0.obs;
  RxInt cardsBought = 0.obs;
  RxInt died = 0.obs;
  RxInt cardsPlayed = 0.obs;
  RxInt damageTaken = 0.obs;

  SignedUser(String name) {
    username = name.obs;
    updateRecord(0);
  }

  updateRecord(int score) async {
    if (hasInternetConnection) {
      var href = FirebaseDatabase.instance.ref('scores');
      final snapshot = await href.child(username.value).get();

      if (snapshot.exists) {
        score = max(score, snapshot.value as int);
      }
      record.value = score;
      href.update({username.value: record.value});
    }
  }
}
