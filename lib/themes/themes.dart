
import 'package:medicinadireta/constants/const_strings.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:medicinadireta/core/extension/size_screen_extension.dart';

class Themes {
  static TextStyle _titulo = GoogleFonts.openSans(fontSize: 18.0, color: ConstColors.blue, fontWeight: FontWeight.w600);
  static TextStyle? _subtitulo = GoogleFonts.openSans(fontSize: 16.0, color: ConstColors.blue, fontWeight: FontWeight.w400);
  // static TextStyle _titulo = TextStyle(fontSize: 18.0, color: ConstColors.blue, fontWeight: FontWeight.w600, fontFamily: ConstStrings.fontFamily);
  // static TextStyle? _subtitulo = TextStyle(fontSize: 16.0, color: ConstColors.blue, fontWeight: FontWeight.w400, fontFamily: ConstStrings.fontFamily);

  static InputDecorationTheme inputDecorationTheme([TextTheme? textTheme]) {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.all(10),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      // //Focus no input sem error
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: ConstColors.fillColor)),
      // //Input em modo de bloqueado
      disabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: ConstColors.border)),
      // //Sem focus, input nao teve evento
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: ConstColors.border)),
      // //Borda global aqui
      border: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: ConstColors.border)),
      // //Com error sem evento, ou seja o focus esta em outro input
      errorBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: ConstColors.danger)),
      // //Com error e o focus no input
      focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: ConstColors.danger)),
      hintStyle: _subtitulo?.copyWith(color: Colors.grey, fontSize: 14.spEx),
      helperStyle: _subtitulo?.copyWith(color: ConstColors.colorText),
      errorStyle: _subtitulo?.copyWith(color: ConstColors.danger, fontSize: 14.spEx),
      labelStyle: _titulo.copyWith(fontSize: 16.spEx, fontWeight: FontWeight.w900),
      helperMaxLines: 5,
      errorMaxLines: 5,
    );
  }

  static TextTheme openSansTextTheme([TextTheme? textTheme]) {
    textTheme ??= ThemeData.light().textTheme;
    return TextTheme(
      headline1: TextStyle(fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5, fontFamily: ConstStrings.fontFamily),
      headline2: TextStyle(fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5, fontFamily: ConstStrings.fontFamily),
      headline3: TextStyle(fontSize: 48, fontWeight: FontWeight.w400, fontFamily: ConstStrings.fontFamily),
      headline4: TextStyle(fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25, fontFamily: ConstStrings.fontFamily),
      headline5: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, fontFamily: ConstStrings.fontFamily),
      headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15, fontFamily: ConstStrings.fontFamily),
      subtitle1: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15, fontFamily: ConstStrings.fontFamily),
      subtitle2: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, fontFamily: ConstStrings.fontFamily),
      bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5, fontFamily: ConstStrings.fontFamily),
      bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, fontFamily: ConstStrings.fontFamily),
      button: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25, fontFamily: ConstStrings.fontFamily),
      caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, fontFamily: ConstStrings.fontFamily),
      overline: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5, fontFamily: ConstStrings.fontFamily),
    );
  }

  final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryTextTheme: GoogleFonts.openSansTextTheme(),
    backgroundColor: ConstColors.backgroundDefault,
    // primaryTextTheme: Themes.openSansTextTheme(),
    primaryIconTheme: const IconThemeData(color: ConstColors.blue),
    primaryColor: ConstColors.blue,
    unselectedWidgetColor: ConstColors.orange,
    iconTheme: const IconThemeData(color: ConstColors.blue),
    colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.light,
        primarySwatch: ConstColors.createMaterialColor(ConstColors.blue),
        accentColor: ConstColors.orange,
        cardColor: Colors.white,
        backgroundColor: Colors.white,
        errorColor: Colors.red),
    tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: _subtitulo,
        unselectedLabelStyle: _subtitulo,
        labelColor: Colors.white,
        unselectedLabelColor: ConstColors.blue),

    /// App Bar Geral
    appBarTheme: AppBarTheme(
      toolbarHeight: 70.0,
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      actionsIconTheme: IconThemeData(color: ConstColors.blue),
      iconTheme: IconThemeData(color: ConstColors.blue),
      elevation: 2.0,
      centerTitle: true,
      titleTextStyle: _titulo.copyWith(color: ConstColors.orange),
    ),
    textTheme: TextTheme(
      /// Está usando na tela de suporte
      headline6: _subtitulo,

      ///Título da agenda subtitle1
      subtitle1: _titulo,

      ///Usar para Sub-titulo do subtitle2
      subtitle2: _subtitulo?.copyWith(color: ConstColors.colorText),

      ///Formataçao para os buttoes
      button: _subtitulo?.copyWith(color: Colors.white),

      ///Sub-titulo dos cards dos agendamentos bodyText2
      bodyText2: _subtitulo?.copyWith(color: ConstColors.colorText),

      /// Está usando na versao do APP bodyText1
      bodyText1: _subtitulo,
    ),
    buttonTheme: const ButtonThemeData(buttonColor: ConstColors.fillColor, height: 50, minWidth: 250, textTheme: ButtonTextTheme.primary),
    inputDecorationTheme: Themes.inputDecorationTheme(),
  );

  final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: ConstColors.backgroundDefault,

    // primaryTextTheme: Themes.openSansTextTheme(),
    primaryTextTheme: GoogleFonts.openSansTextTheme(),
    primaryIconTheme: const IconThemeData(color: ConstColors.blue),
    primaryColor: ConstColors.blue,
    unselectedWidgetColor: ConstColors.orange,
    iconTheme: const IconThemeData(color: ConstColors.blue),
    colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        primarySwatch: ConstColors.createMaterialColor(ConstColors.blue),
        accentColor: ConstColors.orange,
        cardColor: Colors.white,
        backgroundColor: Colors.white,
        errorColor: Colors.red),
    tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: _subtitulo,
        unselectedLabelStyle: _subtitulo,
        labelColor: Colors.white,
        unselectedLabelColor: ConstColors.blue),

    /// App Bar Geral
    appBarTheme: AppBarTheme(
      toolbarHeight: 70.0,
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      actionsIconTheme: const IconThemeData(color: ConstColors.blue),
      iconTheme: const IconThemeData(color: ConstColors.blue),
      elevation: 2.0,
      centerTitle: true,
      titleTextStyle: _titulo.copyWith(color: ConstColors.orange),
    ),
    textTheme: TextTheme(
      /// Está usando na tela de suporte
      headline6: _subtitulo,

      ///Título da agenda subtitle1
      subtitle1: _titulo,

      ///Usar para Sub-titulo do subtitle2
      subtitle2: _subtitulo?.copyWith(color: ConstColors.colorText),

      ///Formataçao para os buttoes
      button: _subtitulo?.copyWith(color: Colors.white),

      ///Sub-titulo dos cards dos agendamentos bodyText2
      bodyText2: _subtitulo?.copyWith(color: ConstColors.colorText),

      /// Está usando na versao do APP bodyText1
      bodyText1: _subtitulo,
    ),
    buttonTheme: const ButtonThemeData(buttonColor: ConstColors.fillColor, height: 50, minWidth: 250, textTheme: ButtonTextTheme.primary),
    inputDecorationTheme: Themes.inputDecorationTheme(),
  );
}
