import 'package:medicinadireta/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppAlert {
  AppAlert._();

  static const TOP = SnackPosition.TOP;
  static const BOTTOM = SnackPosition.BOTTOM;

  static alertError({required String title, String? body, SnackPosition snackPosition = AppAlert.BOTTOM, int seconds = 5}) {
    Get.snackbar(
      '',
      '',
      // ignore: unnecessary_string_interpolations
      titleText: Text('$title', style: GoogleFonts.openSans(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white)),
      messageText: Text('$body', style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
      snackPosition: snackPosition,
      backgroundColor: ConstColors.danger,
      colorText: Colors.white,
      duration: Duration(seconds: seconds),
      borderRadius: 0.0,
      icon: Icon(Icons.warning_amber_outlined, color: Colors.white, size: 35),
    );
  }

  static alertWarning({required String title, String? body, SnackPosition snackPosition = AppAlert.BOTTOM, int seconds = 5}) {
    Get.snackbar(
      '',
      '',
      titleText: Text('$title', style: GoogleFonts.openSans(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white)),
      messageText: Text('$body', style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
      snackPosition: snackPosition,
      backgroundColor: ConstColors.orange,
      colorText: Colors.white,
      duration: Duration(seconds: seconds),
      borderRadius: 0.0,
      icon: Icon(Icons.warning_amber_outlined, color: Colors.white, size: 35),
    );
  }

  static alertSuccess({required String title, String? body, SnackPosition snackPosition = AppAlert.BOTTOM, int seconds = 5}) {
    Get.snackbar(
      '',
      '',
      titleText: Text('$title', style: GoogleFonts.openSans(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white)),
      messageText: Text('$body', style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
      snackPosition: snackPosition,
      backgroundColor: ConstColors.greenDark,
      colorText: Colors.white,
      duration: Duration(seconds: seconds),
      borderRadius: 0.0,
      icon: Icon(Icons.warning_amber_outlined, color: Colors.white, size: 35),
    );
  }

  static alertAll({required int statusCode}) {
    switch (statusCode) {
      case 200:
      case 201:
        AppAlert.alertSuccess(title: 'Sucesso!', body: 'Requisição com sucesso');
        break;
      case 400:
        AppAlert.alertWarning(title: 'Ops!', body: 'Não foi possível enviar requisição');
        break;
      case 401:
        AppAlert.alertWarning(title: 'Ops!', body: 'Sua sessão encerrou, logue e tente novamente.');
        break;
      case 404:
        AppAlert.alertWarning(title: 'Ops!', body: 'Página não encontrada');
        break;
      default:
    }
  }
}
