import 'package:medicinadireta/modules/change_password/domain/entities/network/response_change_password.dart';
import 'package:medicinadireta/modules/change_password/infra/models/change_password_ext.dart';

class ResponseChangePasswordExt extends ResponseChangePassword {
  final ChangePasswordExt? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  final String? odata;

  ResponseChangePasswordExt({this.statusCode, this.statusMessage, this.errorMessage, this.odata, required this.model});

  factory ResponseChangePasswordExt.fromMap({Map<String, dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseChangePasswordExt(
      model: data != null ? ChangePasswordExt.fromMap(data) : null,
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      odata: odata,
    );
  }
}