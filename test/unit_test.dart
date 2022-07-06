import 'package:dotw/cards/card.dart';
import 'package:dotw/cards/defensive_cards/basic_defense.dart';
import 'package:dotw/cards/offensive_cards/basic_attack.dart';
import 'package:dotw/entities/enemies/elevated_button_enemy.dart';
import 'package:dotw/entities/enemies/enemy.dart';
import 'package:dotw/entities/enemies/text_field_enemy.dart';
import 'package:dotw/entities/player.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/state_manager.dart';

void main() {
  group('Player tests', () {
    test('Taking direct damage test', () {
      Player player = Player(
          name: 'a',
          description: 'b',
          hp: 5.obs,
          hpMax: 5.obs,
          dmg: 0.obs,
          block: 0.obs,
          energy: 5.obs,
          money: 0.obs,
          energyMax: 5.obs,
          handSize: 5.obs,
          deck: [BasicAttack()].obs);
      Enemy enemy = ElevatedButtonEnemy();
      enemy.attack(player);
      expect(player.hp.value, 4);
    });
    test('Taking partial damage test', () {
      Player player = Player(
          name: 'a',
          description: 'b',
          hp: 5.obs,
          hpMax: 5.obs,
          dmg: 0.obs,
          block: 1.obs,
          energy: 5.obs,
          money: 0.obs,
          energyMax: 5.obs,
          handSize: 5.obs,
          deck: [BasicAttack()].obs);
      player.block.value = 1;
      Enemy enemy = TextFieldEnemy();
      enemy.attack(player);
      expect(player.hp.value, 4);
    });
    test('Blocking all damage test', () {
      Player player = Player(
          name: 'a',
          description: 'b',
          hp: 5.obs,
          hpMax: 5.obs,
          dmg: 0.obs,
          block: 10.obs,
          energy: 5.obs,
          money: 0.obs,
          energyMax: 5.obs,
          handSize: 5.obs,
          deck: [BasicAttack()].obs);
      Enemy enemy = ElevatedButtonEnemy();
      enemy.attack(player);
      expect(player.hp.value, 5);
    });
  });

  group('Enemy tests', () {
    test('Attacking non-blocking enemy', () {
      Player player = Player(
          name: 'a',
          description: 'b',
          hp: 3.obs,
          hpMax: 5.obs,
          dmg: 1.obs,
          block: 0.obs,
          energy: 5.obs,
          money: 0.obs,
          energyMax: 5.obs,
          handSize: 5.obs,
          deck: [BasicAttack()].obs);
      Enemy enemy = ElevatedButtonEnemy();
      player.attack(enemy);
      expect(enemy.hp.value, 1);
    });

    test('Attacking blocking enemy', () {
      Player player = Player(
          name: 'a',
          description: 'b',
          hp: 3.obs,
          hpMax: 5.obs,
          dmg: 1.obs,
          block: 0.obs,
          energy: 5.obs,
          money: 0.obs,
          energyMax: 5.obs,
          handSize: 5.obs,
          deck: [BasicAttack()].obs);
      Enemy enemy = ElevatedButtonEnemy();
      enemy.move(player, 0);
      player.attack(enemy);
      expect(enemy.hp.value, 2);
    });

    test('Enemy move set test', () {
      Player player = Player(
          name: 'a',
          description: 'b',
          hp: 2.obs,
          hpMax: 5.obs,
          dmg: 1.obs,
          block: 0.obs,
          energy: 5.obs,
          money: 0.obs,
          energyMax: 5.obs,
          handSize: 5.obs,
          deck: [BasicAttack()].obs);
      Enemy enemy = ElevatedButtonEnemy();
      enemy.move(player, 0);
      enemy.move(player, 1);
      enemy.move(player, 2);
      expect(player.isDead.value, true);
    });
  });

  group('Card tests', () {
    Enemy enemy = ElevatedButtonEnemy();
    test('Attack card test', () {
      Player player = Player(
          name: 'a',
          description: 'b',
          hp: 3.obs,
          hpMax: 5.obs,
          dmg: 10.obs,
          block: 0.obs,
          energy: 5.obs,
          money: 0.obs,
          energyMax: 5.obs,
          handSize: 5.obs,
          deck: [BasicAttack()].obs);
      GameCard card = BasicAttack();
      card.play(player, enemy);
      expect(player.dmg.value, 1);
    });

    test('Block card test', () {
      Player player = Player(
          name: 'a',
          description: 'b',
          hp: 3.obs,
          hpMax: 5.obs,
          dmg: 10.obs,
          block: 0.obs,
          energy: 5.obs,
          money: 0.obs,
          energyMax: 5.obs,
          handSize: 5.obs,
          deck: [BasicAttack()].obs);
      GameCard card = BasicDefense();
      card.play(player, enemy);
      expect(player.block.value, 1);
    });

    test('Multiple block cards test', () {
      Player player = Player(
          name: 'a',
          description: 'b',
          hp: 3.obs,
          hpMax: 5.obs,
          dmg: 10.obs,
          block: 0.obs,
          energy: 5.obs,
          money: 0.obs,
          energyMax: 5.obs,
          handSize: 5.obs,
          deck: [BasicAttack()].obs);
      GameCard card = BasicDefense();
      card.play(player, enemy);
      card.play(player, enemy);
      card.play(player, enemy);
      card.play(player, enemy);
      card.play(player, enemy);
      expect(player.block.value, 5);
    });
  });
}
