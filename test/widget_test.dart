import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:skeleton/main.dart';
import 'package:skeleton/second_page.dart';

void main() {
  late MaterialApp myHomePage;

  setUp(() {
    myHomePage = const MaterialApp(home: MyHomePage(title: 'title',));
  });
  testWidgets('UI validation', (widgetTester) async{

    // pump
    await widgetTester.pumpWidget(myHomePage);

    // find title
    expect(find.text('title'), findsOneWidget);

    // find fab
    expect(find.byType(FloatingActionButton), findsOneWidget);

    // find Column and its children
    expect(find.byKey(const Key('Center')), findsOneWidget);
    expect(find.descendant(of: find.byType(Center), matching: find.byType(Column)), findsOneWidget);
    expect(find.descendant(of: find.byType(Column), matching: find.text('You have pushed the button this many times:')), findsOneWidget);
    expect(find.descendant(of: find.byType(Column), matching: find.byKey(const Key('Counter'))), findsOneWidget);

  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('When tap move button, then move to SecondPage', (widgetTester) async{
    await widgetTester.pumpWidget(myHomePage);

    await widgetTester.tap(find.byKey(const Key('button_go_to_second_page')));
    await widgetTester.pumpAndSettle();

    expect(find.byType(MyHomePage), findsNothing);
    expect(find.byType(SecondPage), findsOneWidget);
    expect(find.text('This is SecondPage'), findsOneWidget);
  });

  testWidgets('When tap back button on SecondPage, then go back to previous page', (widgetTester) async{
    await widgetTester.pumpWidget(myHomePage);

    await widgetTester.tap(find.byKey(const Key('button_go_to_second_page')));
    await widgetTester.pumpAndSettle();

    expect(find.byType(MyHomePage), findsNothing);
    expect(find.byType(SecondPage), findsOneWidget);
    expect(find.text('This is SecondPage'), findsOneWidget);

    await widgetTester.tap(find.byKey(const Key('button_go_back')));
    await widgetTester.pumpAndSettle();

    expect(find.byType(SecondPage), findsNothing);
    expect(find.byType(MyHomePage), findsOneWidget);
  });

}
