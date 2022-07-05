import 'package:dotw/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cards/card.dart';
import '../cards/defensive_cards/basic_defense.dart';
import '../cards/offensive_cards/basic_attack.dart';
import '../constants/colors.dart';
import '../entities/player.dart';

class Shop extends StatefulWidget {
  static const String route = '/shop';
  final Player player;

  const Shop({Key? key, required this.player}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  var healthCost = 1.obs;
  var energyCost = 1.obs;
  var healCost = 1.obs;

  List<GameCard> cardsInShop = [
    BasicAttack(),
    BasicAttack(),
    BasicAttack(),
    BasicDefense(),
    BasicDefense(),
    BasicDefense(),
  ];

  RxList<bool> cardInShopIsBought = [false, false, false, false, false, false].obs;

  late Player player;

  @override
  void initState() {
    player = widget.player;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(widget.player),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.transparent,
                      ),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.favorite,
                            size: 60,
                            color: Colors.redAccent,
                          ),
                          Text('123\$'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          elevation: 0, primary: Colors.transparent),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.flash_on_sharp,
                            size: 60,
                            color: GameColors.goldColor,
                          ),
                          Text('123\$'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          elevation: 0, primary: Colors.transparent),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.healing,
                            size: 60,
                            color: Colors.green,
                          ),
                          Text('123\$'),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    for (int i = 0; i < 3; i++) buildShopCard(i),
                  ].toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    for (int i = 3; i < 6; i++) buildShopCard(i),
                  ].toList(),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Leave the shop', style: TextStyle(fontSize: 30),),
                ),
              )
          )
        ],
      ),
    );
  }

  Widget buildShopCard(int index) {
    return Obx(
      () => ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            elevation: 0,
          ),
          onPressed: cardInShopIsBought[index]
              ? null
              : () {
                  cardInShopIsBought[index] = true;
                },
          child: Column(
            children: [cardsInShop[index].render(), Text('price')],
          )),
    );
  }
}
