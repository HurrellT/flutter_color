import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_color/widgets/color_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_color/main.dart';

void main() {

  Widget makeWidgetTestable({Widget child}) {
    return MaterialApp(home: Flex(direction: Axis.horizontal,
    children: [child],));
  }
  
  testWidgets('Color Widget test', (WidgetTester tester) async {
    ColorWidget colorWidget = ColorWidget(hexColor: '#000000', locked: false, lockingFunction: () {});
    
    await tester.pumpWidget(makeWidgetTestable(child: colorWidget));

    expect(find.text('#111111'), findsNothing);
    expect(find.text('#000000'), findsOneWidget);
  });
}
