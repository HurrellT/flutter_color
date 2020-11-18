import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/base_widget.dart';
import '../widgets/color_widget.dart';

import '../utils/hex_generator.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Map<String, bool> colorPalette;
  HexGenerator hexGenerator = HexGenerator();

  @override
  void initState() {
    super.initState();
    colorPalette = Map();
    for (int i = 0; i < 5; i++) {
      colorPalette[hexGenerator.generateRandomHexColor()] = false;
    }
  }

  changeLockState(String hexColor) {
    setState(() {
      colorPalette[hexColor] = !colorPalette[hexColor];
    });
  }

  @override
  Widget build(BuildContext context) {
    var colorList = [
      ColorWidget(
        hexColor: colorPalette.keys.toList()[0],
        locked: colorPalette.values.toList()[0],
        lockingFunction: changeLockState,
      ),
      ColorWidget(
        hexColor: colorPalette.keys.toList()[1],
        locked: colorPalette.values.toList()[1],
        lockingFunction: changeLockState,
      ),
      ColorWidget(
        hexColor: colorPalette.keys.toList()[2],
        locked: colorPalette.values.toList()[2],
        lockingFunction: changeLockState,
      ),
      ColorWidget(
        hexColor: colorPalette.keys.toList()[3],
        locked: colorPalette.values.toList()[3],
        lockingFunction: changeLockState,
      ),
      ColorWidget(
        hexColor: colorPalette.keys.toList()[4],
        locked: colorPalette.values.toList()[4],
        lockingFunction: changeLockState,
      ),
    ];

    return BaseWidget(
      builder: (context, sizingInformation) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            key: Key('refreshButton'),
            child: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                var originalColorPalette = colorPalette;
                colorPalette = Map();
                for (int i = 0; i < 5; i++) {
                  originalColorPalette.values.toList()[i] == true
                      ? colorPalette[originalColorPalette.keys.toList()[i]] =
                  true
                      : colorPalette[hexGenerator.generateRandomHexColor()] = false;
                }
              });
            },
          ),
          body: sizingInformation.orientation == Orientation.landscape
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: colorList,
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: colorList,
          ),
        );
      },
    );
  }
}
