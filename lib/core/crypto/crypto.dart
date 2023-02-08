import 'dart:convert';

import 'package:crypto/crypto.dart';

class Crypto {
  static String cryptoString(String value) {
    final List<int> bytes = utf8.encode(value.toUpperCase());
    return '${sha256.convert(bytes)}';
  }
  static String cryptoMD5(String value) {
    final List<int> bytes = utf8.encode(value);
    return '${md5.convert(bytes)}';
  }
}