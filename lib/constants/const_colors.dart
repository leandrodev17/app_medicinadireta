import 'package:flutter/material.dart';

class ConstColors {
  ConstColors._();

  //GLOBAL
  static const Color orange = Color(0xFFFA775D);
  static const Color blue = Color(0xFF0C2D59);
  static const Color fillColor = Color(0xFF263545);
  static const Color lightFillColor = Color(0xFF465D87);
  static const Color lightGrey = Color(0xFFD3D3D3);
  static const Color grey = Color(0xFFA3A3A3);
  static const Color ligtherGrey = Color(0xFFF3F3F3);
  static const Color greenDark = Color(0xFF039B6A);

  //CORES PARA CAMPOS DO FORMULÁRIO
  static const Color placeholder = Color(0xFF8F92B7);
  static const Color border = Color(0xFFB6B9D0);
  static const Color danger = Color(0xFFD5543A);
  static const Color colorText = Color(0xFF312F4F);
  static const Color inputLocked = Color(0xFFEAEAF4);
  static const Color backgroundAnamnese = Color(0xFFdedede);
  static const Color cursorColor = colorText;

  static const Color backgroundDefault = Color(0xFFE5E5E5);
  static const Color greyCard = Color(0xFF9D9D9D);
  static const Color borderItemMenu = Color(0xFFCACBD7);

  static const Color white = Color(0xFFFFFFFF);
  static const Color cinza = Color(0xFF656565);
  static const Color cinza2 = Color(0xFF7D7D7D);
  static const Color cinza3 = Color(0XFFBBBBBB);
  static const Color cinza4 = Color(0XFFEEEEEE);
  static const Color graphite = Color(0XFF333333);
  static const Color observationColor = Color(0XFFFFA500);
  static const Color observationColorText = Color(0XFFFFE5B5);
  static const Color scheduleGridColorText = Color(0XFF2B96E6);
  static const Color scheduleGridColor = Color(0XFFD4EAFA);
  static const Color ffA674FF = Color(0xFFA674FF);
  static const Color ff5897F5 = Color(0xFF5897F5);
  static const Color ffEB3223 = Color(0xFFEB3223);
  static const Color ff7D7D7D = Color(0xFF7D7D7D);
  static const Color ff284066 = Color(0xFF284066);
  static const Color ffFEE3DE = Color(0XFFFEE3DE);
  static const Color ff969696 = Color(0XFF969696);

  static MaterialColor primarySwatch = createMaterialColor(blue);

  static MaterialColor createMaterialColor(Color color) {
    final List strengths = <double>[.05];
    final Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (double strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }
}
