import 'package:dotw/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Leader',
              style: GoogleFonts.vt323(
                textStyle: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
            ),
            Text(
              'board',
              style: GoogleFonts.vt323(
                textStyle: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent),
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: hasInternetConnection
          ? FutureBuilder(
              future: getScores(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as Map<String, dynamic>;

                  List<String> players = data.keys.toList()
                    ..sort((a, b) => -data[a]!.compareTo(data[b]!));
                  int size = players.length;

                  List<Widget> allPlayers = [];
                  allPlayers.add(
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Colors.black)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rank',
                            style: GoogleFonts.vt323(
                              textStyle: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            'Nickname',
                            style: GoogleFonts.vt323(
                              textStyle: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            'Points',
                            style: GoogleFonts.vt323(
                              textStyle: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );

                  for (int i = 0; i < size; i++) {
                    allPlayers.add(
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(10),
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Text(
                                    '#${i + 1}',
                                    style: GoogleFonts.vt323(
                                        textStyle: const TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                const Icon(
                                  Icons.account_circle_rounded,
                                  color: Colors.black,
                                  size: 35,
                                ),
                              ],
                            ),
                            Text(
                              players[i],
                              style: GoogleFonts.vt323(
                                  textStyle: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Text(
                              '${data[players[i]]}',
                              style: GoogleFonts.vt323(
                                textStyle: const TextStyle(
                                    fontSize: 26, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Container(
                    margin: const EdgeInsets.all(30),
                    child: ListView(
                      children: allPlayers,
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )
          : Text(
              'Unable to load Leaderboard, because no internet connection found'
                  .tr),
    );
  }
}
/*Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 600,
                      margin: EdgeInsets.all(20),
                      child: ListView(
                        children: (data.keys.toList()
                              ..sort((a, b) => -data[a]!.compareTo(data[b]!)))
                            .map(
                              (player) => Container(
                                color: Colors.grey,
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  '$player: ${data[player]}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ],
            );*/
