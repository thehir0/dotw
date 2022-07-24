import 'package:dotw/widgets/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Main menu tests', () {
    const mainMenu = MaterialApp(
      home: MainMenu(),
    );

    final settingsButton = find.byKey(const ValueKey('SettingsButton'));
    final deckButton = find.byKey(const ValueKey('DeckButton'));
    final enemiesButton = find.byKey(const ValueKey('EnemiesButton'));

    testWidgets('Settings button test', (WidgetTester tester) async {
      await tester.pumpWidget(mainMenu);
      await tester.tap(settingsButton);
      await tester.pump();

      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('Deck button test', (WidgetTester tester) async {
      await tester.pumpWidget(mainMenu);
      await tester.tap(deckButton);
      await tester.pump();

      expect(find.byKey(const ValueKey('DeckDialog')), findsOneWidget);
    });

    testWidgets('Enemies button test', (WidgetTester tester) async {
      await tester.pumpWidget(mainMenu);
      await tester.tap(enemiesButton);
      await tester.pump();

      expect(find.byKey(const ValueKey('EnemiesDialog')), findsOneWidget);
    });
  });
}
