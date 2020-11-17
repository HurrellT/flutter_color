import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ColorWidget extends StatelessWidget {
  final String hexColor;
  final bool locked;
  final Function lockingFunction;

  ColorWidget(
      {@required this.hexColor,
        @required this.locked,
        @required this.lockingFunction});

  static int getColorHexFromString(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var isLandscape = mediaQuery.orientation == Orientation.landscape;
    var edgeInsets = const EdgeInsets.all(20);
    return Flexible(
      flex: 5,
      child: Stack(
        children: [
          AnimatedContainer(
              color: Color(getColorHexFromString(hexColor)),
              duration: const Duration(milliseconds: 500)),
          Align(
            alignment:
            isLandscape ? Alignment.topCenter : Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: ClipOval(
                child: Material(
                  elevation: 2,
                  color: Colors.white,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: InkWell(
                      splashColor: Colors.grey,
                      child: locked
                          ? Padding(
                        padding: edgeInsets,
                        child: Icon(Icons.lock_outline),
                      )
                          : Padding(
                        padding: edgeInsets,
                        child: Icon(Icons.lock_open),
                      ),
                      onTap: () {
                        lockingFunction(hexColor);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: isLandscape ? height * 0.16 : 10,
            top: isLandscape ? height * 0.65 : 10,
            left: isLandscape ? 10 : width * 0.05,
            right: isLandscape ? 10 : width * 0.6,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: 100,
                    height: 40,
                    child: Center(
                      child: AnimatedSwitcher(
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                              opacity: animation, child: child);
                        },
                        duration: const Duration(milliseconds: 500),
                        child: SelectableText(
                          hexColor,
                          key: ValueKey<String>(hexColor),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
