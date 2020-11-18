import 'package:flutter_color/utils/hex_generator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class HexGeneratorMock extends Mock implements HexGenerator {}

void main() {
  test('The Hex generator generates a Hex color', () {
    HexGeneratorMock hexGeneratorMock = HexGeneratorMock();

    when(hexGeneratorMock.generateRandomHexColor()).thenReturn("#000000");
    expect(hexGeneratorMock.generateRandomHexColor(), "#000000");
    verify(hexGeneratorMock.generateRandomHexColor());
  });
}