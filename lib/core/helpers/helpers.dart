import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:medicinadireta/core/widgets/app_log.dart';

class Helpers {
  Helpers._();

  static Uint8List? convertBase64MemoryImage(String? value) {
    try {
      if (value == null || value.isEmpty) return null;
      Uint8List _bytesImage = Base64Decoder().convert(value);
      return _bytesImage;
    } catch (e) {
      return null;
    }
  }

  static bool isNullOrEmpty(String? value, {bool considerWhiteSpaceAsEmpty = false}) {
    RegExp _emptyRegex = RegExp(r'^\s*$');
    if (considerWhiteSpaceAsEmpty) return value == null || _emptyRegex.hasMatch(value);
    return value?.isEmpty ?? true;
  }

  static launchURLOpenLink(String url) async {
    try {
      if (url == '' || url.isEmpty) return null;
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false, forceWebView: false);
      } else {
        throw 'Não foiu possível abrir o link $url';
      }
    } catch (e) {
      AppLog.d("Não foiu possível abrir o link $url");
    }
  }

  static launchPhone(String tel) async {
    try {
      if (tel == '' || tel.isEmpty) return null;
      if (await canLaunch(tel)) {
        await launch(tel);
      } else {
        throw 'Não foiu possível abrir o tel $tel';
      }
    } catch (e) {
      AppLog.d("Não foiu possível abrir o tel $tel");
    }
  }

  static String urlWhatsApp(String phone, String message) {
    if (Platform.isAndroid) {
      return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
    } else {
      return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
    }
  }

  static launchEmail(String email) async {
    try {
      if (email == '' || email.isEmpty) return null;
      if (await canLaunch(email)) {
        await launch(email);
      } else {
        throw 'Não foiu possível abrir o email $email';
      }
    } catch (e) {
      AppLog.d("Não foiu possível abrir o email $email");
    }
  }

  static bool? isEmptyApp(dynamic value) {
    if (value is String) {
      return value.toString().trim().isEmpty;
    }
    if (value is Iterable || value is Map) {
      return value.isEmpty as bool?;
    }
    return false;
  }

  static bool isNull(dynamic value) => value == null;
  static bool? isNullOrBlank(dynamic value) {
    if (isNull(value)) {
      return true;
    }

    // Pretty sure that isNullOrBlank should't be validating
    // iterables... but I'm going to keep this for compatibility.
    return isEmptyApp(value);
  }

  static int formatCor(String? cor) {
    if (cor == null || cor.isEmpty) return 0xFF67B1FF;
    String? remove = cor.replaceAll('#', '').toUpperCase();
    String? stringData = remove != '' ? "0xFF$remove" : null;
    int? corFormatData = stringData != null ? int.parse(stringData.toString()) : null;
    return corFormatData ?? 0xFF67B1FF;
  }

  //here goes the function
  static String parseHtmlString(String htmlString) {
    if (htmlString == null || htmlString == '' || htmlString.isEmpty) return '';
    final document = parse(htmlString);
    final String parsedString = parse(document.body?.text).documentElement!.text;

    return parsedString;
  }
}
