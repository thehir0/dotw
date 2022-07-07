import 'dart:math';

import 'package:dotw/widgets/shop/app_bar_shop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../cards/card.dart';
import '../constants/colors.dart';
import '../entities/player.dart';

class Shop extends StatefulWidget {
  static const String route = '/shop';
  final Player player;
  final int room;

  const Shop({
    Key? key,
    required this.player,
    required this.room,
  }) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  late RxInt healthCost;
  late RxInt energyCost;
  late RxInt healCost;

  late List<GameCard> cardsInShop;
  late List<int> cardsInShopPrices;
  RxList<bool> cardInShopIsBought =
      [false, false, false, false, false, false].obs;

  late Player player;

  @override
  void initState() {
    var rng = Random();
    player = widget.player;
    cardsInShop = GameCard.getCards(6);
    cardsInShopPrices =
        cardsInShop.map((e) => e.rarity * 10 + rng.nextInt(21) - 5).toList();
    healthCost = (widget.room * 5).obs;
    energyCost = (widget.room * 5).obs;
    healCost = (widget.room * 5).obs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildShopAppBar(widget.player),
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
                      onPressed: () {
                        if (player.money.value >= healthCost.value) {
                          player.money.value -= healthCost.value;
                          player.hpMax.value += 1;
                          healthCost.value *= 2;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.transparent,
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.favorite,
                            size: 60,
                            color: Colors.redAccent,
                          ),
                          Obx(() => Text('$healthCost\$')),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: ElevatedButton(
                      onPressed: () {
                        if (player.money.value >= energyCost.value) {
                          player.money.value -= energyCost.value;
                          player.energyMax.value += 1;
                          energyCost.value *= 2;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0, primary: Colors.transparent),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.flash_on_sharp,
                            size: 60,
                            color: GameColors.goldColor,
                          ),
                          Obx(() => Text('$energyCost\$')),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: ElevatedButton(
                      onPressed: () {
                        if (player.money.value >= healCost.value) {
                          player.money.value -= healCost.value;
                          player.hp.value = player.hpMax.value;
                          healCost.value *= 2;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0, primary: Colors.transparent),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.healing,
                            size: 60,
                            color: Colors.green,
                          ),
                          Obx(() => Text('$healCost\$')),
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
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'Leave the shop',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ))
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
                  if (player.money.value >= cardsInShopPrices[index]) {
                    cardInShopIsBought[index] = true;
                    player.deck.add(cardsInShop[index]);
                    player.money.value -= cardsInShopPrices[index];
                  }
                },
          child: Column(
            children: [
              cardsInShop[index].render(),
              Text('${cardsInShopPrices[index]}\$'),
            ],
          )),
    );
  }
}
