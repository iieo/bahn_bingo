import 'dart:math';

String generateRandomId() {
  final random = Random();
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  String id = '';
  for (var i = 0; i < 4; i++) {
    id += chars[random.nextInt(chars.length)];
  }

  return id;
}
