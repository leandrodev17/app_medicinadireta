import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/response_new_phone.dart';
import 'package:medicinadireta/modules/modules_helpers/infra/models/model_new_phone_ext.dart';

class ResponseNewPhoneExt extends ResponseNewPhone {
  final ModelNewPhoneExt? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseNewPhoneExt({this.statusCode, this.statusMessage, this.errorMessage, required this.model});

  factory ResponseNewPhoneExt.fromMap({dynamic data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseNewPhoneExt(
      model: data != null ? ModelNewPhoneExt.fromMap(data) : null,
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
