import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Leaderboard extends StatefulWidget {
  static const String route = 'leaderboard';

  const Leaderboard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  Future<Map<String, dynamic>> getScores() async {
    var database = FirebaseDatabase.instance.ref('scores');
    var snapshot = await database.get();
    Map<String, dynamic> data = {};
    if (snapshot.value != null) {
      data = Map<String, dynamic>.from(snapshot.value as Map);
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: FutureBuilder(
        future: getScores(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as Map<String, dynamic>;
            return Center(
              child: ListView(
                children: (data.keys.toList()
                      ..sort((a, b) => -data[a]!.compareTo(data[b]!)))
                    .map((player) => Text('$player: ${data[player]}'))
                    .toList(),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
