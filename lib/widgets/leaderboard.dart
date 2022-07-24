import 'package:dotw/constants/colors.dart';
import 'package:dotw/constants/fonts.dart';
import 'package:dotw/main.dart';
import 'package:dotw/widgets/leaderboard_template.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Leaderboard extends StatefulWidget {
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

                  for (int i = 3; i < size; i++) {
                    allPlayers.add(Container(
                      height: 72,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                children: [
                                  Text(
                                    '${i + 1}',
                                    style: const TextStyle(
                                        fontFamily: beaufort,
                                        fontSize: 22,
                                        color: Colors.black87),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.grey,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      players[i],
                                      style: const TextStyle(
                                          fontFamily: gillSans,
                                          fontSize: 14,
                                          color: Colors.black87),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Center(
                                child: Text(
                                  '${data[players[i]]}',
                                  style: const TextStyle(
                                      fontFamily: gillSans,
                                      fontSize: 14,
                                      color: Colors.black87),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
                  }

                  return Column(
                    children: [
                      Flexible(
                        flex: 4,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          color: GameColors.first,
                          padding: const EdgeInsets.only(
                              left: 12, top: 40, right: 12, bottom: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /**TITLE**/
                              Flexible(
                                flex: 2,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.arrow_back_ios_new,
                                              color: Colors.white,
                                              size: 32,
                                            ),
                                            onPressed: () => Get.back(),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 8,
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Center(
                                              child: Text(
                                            'Leaderboard'.tr,
                                            style: const TextStyle(
                                                fontSize: 45,
                                                fontFamily: beaufort,
                                                color: Colors.white),
                                          )),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              /**TITLE_END**/
                              Flexible(
                                flex: 8,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: LeaderboardTemplate(
                                          username: players[1],
                                          record: data[players[1]],
                                          bottomMargin: 0,
                                          radius: 40,
                                          place: '2',
                                          medalColor: GameColors.silver),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: LeaderboardTemplate(
                                          username: players[0],
                                          record: data[players[0]],
                                          bottomMargin: 30,
                                          radius: 55,
                                          place: '1',
                                          medalColor: GameColors.goldColor),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: LeaderboardTemplate(
                                          username: players[2],
                                          record: data[players[2]],
                                          bottomMargin: 0,
                                          radius: 40,
                                          place: '3',
                                          medalColor: GameColors.bronze),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: ListView(
                            padding: const EdgeInsets.all(0),
                            children: allPlayers,
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          : Center(
              child: Text(
              'Unable to load Leaderboard, because no internet connection found'
                  .tr,
              style: const TextStyle(color: Colors.black),
            )),
    );
  }
}
