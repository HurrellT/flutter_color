import 'package:flutter/material.dart';
import 'package:flutter_color/main.dart';
import 'package:flutter_color/screens/home_screen.dart';
import 'package:flutter_color/utils/hex_generator.dart';
import 'package:flutter_color/widgets/color_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  testWidgets('FlutterColor has a refresh button that changes the hex colors',
          (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    
    final HomePageState appState = tester.state(find.byType(HomePage));

    String firstColor = appState.colorPalette.keys.first;

    ColorWidget colorWidget = tester.widget(find.byType(ColorWidget).first);

    expect(colorWidget.hexColor, firstColor);

    await tester.tap(find.byKey(Key('refreshButton')));
    
    await tester.pump();

    String newFirstColor = appState.colorPalette.keys.first;
    colorWidget = tester.widget(find.byType(ColorWidget).first);

    expect(firstColor, isNot(equals(newFirstColor)));

    expect(colorWidget.hexColor, newFirstColor);
  });

  testWidgets('FlutterColor lets you lock a color you like',
          (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final HomePageState appState = tester.state(find.byType(HomePage));

    String firstColor = appState.colorPalette.keys.first;
    bool firstColorLock = appState.colorPalette.values.first;

    ColorWidget colorWidget = tester.widget(find.byType(ColorWidget).first);

    expect(colorWidget.hexColor, firstColor);
    expect(colorWidget.locked, firstColorLock);

    await tester.tap(find.byKey(Key('lockButton')).first);
    await tester.tap(find.byKey(Key('refreshButton')));

    await tester.pump();

    String stillTheSameFirstColor = appState.colorPalette.keys.first;
    colorWidget = tester.widget(find.byType(ColorWidget).first);
    bool newFirstColorLock = appState.colorPalette.values.first;

    expect(firstColor, equals(stillTheSameFirstColor));
    expect(colorWidget.locked, isNot(equals(firstColorLock)));
    expect(colorWidget.locked, equals(newFirstColorLock));
    expect(colorWidget.hexColor, stillTheSameFirstColor);
  });
}