
import 'package:encrypt/encrypt.dart' as enc;

const secret = '1234567890123456';
final key = enc.Key.fromUtf8(secret);
final iv = enc.IV.fromUtf8(secret);

final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));

String encrypt(String text) {
  final encrypted = encrypter.encrypt(text, iv: iv);
  print('Encrypted: ${encrypted.base64}');
  return encrypted.base64;
}

String decrypted(String textDecode) {
  final decrypted = encrypter.decrypt(enc.Encrypted.from64(textDecode), iv: iv);
  print('Decrypted: $decrypted');
  return decrypted;
}
