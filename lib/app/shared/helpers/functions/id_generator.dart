import 'dart:math';

class IdGenerator {
  static const String _chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  static final Random _random = Random();

  static String generate({int length = 10}) {
    return List.generate(
        length, (index) => _chars[_random.nextInt(_chars.length)]).join();
  }
}
