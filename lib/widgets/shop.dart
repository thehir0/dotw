import 'dart:math';

import 'package:dotw/constants/fonts.dart';
import 'package:dotw/widgets/shop/app_bar_shop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../cards/card.dart';
import '../constants/colors.dart';
import '../entities/player.dart';
import '../main.dart';

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
                    height: 100,
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
                          Image.asset(
                            'assets/icon/heart_shop.png',
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/icon/coin_shop.png',
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Obx(
                                () => Text(
                                  '$healthCost',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: gillSans,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
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
                          Image.asset(
                            'assets/icon/thunder_shop.png',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/icon/coin_shop.png',
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Obx(
                                () => Text(
                                  '$energyCost',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: gillSans,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
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
                            size: 70,
                            color: Colors.green,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/icon/coin_shop.png',
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Obx(
                                () => Text(
                                  '$healCost',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: gillSans,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 8,
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
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: GameColors.first),
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        'Leave the shop',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: gillSans,
                            color: Colors.white),
                      ),
                    ),
                  )))
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
                    user?.moneySpent.value += cardsInShopPrices[index];
                    user?.cardsBought.value++;
                  }
                },
          child: Column(
            children: [
              cardsInShop[index].render(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/icon/coin_shop.png',
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    '${cardsInShopPrices[index]}',
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: gillSans,
                        color: Colors.black),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
