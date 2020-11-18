import 'dart:math';

class HexGenerator {
  String generateRandomHexColor() {
    Random random = new Random();
    int length = 6;
    String chars = '0123456789ABCDEF';
    String hex = '#';
    while (length-- > 0) hex += chars[(random.nextInt(16)) | 0];
    return hex;
  }
}