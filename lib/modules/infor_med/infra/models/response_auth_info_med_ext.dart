import 'package:medicinadireta/modules/infor_med/domain/entities/response_auth_info_med.dart';
import 'package:medicinadireta/modules/infor_med/infra/models/auth_info_med_ext.dart';


class ResponseAuthInfoMedExt extends ResponseAuthInfoMed {
  final AuthInfoMedExt? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseAuthInfoMedExt({this.statusCode, this.statusMessage, this.errorMessage, required this.model});

  factory ResponseAuthInfoMedExt.fromMap({dynamic data, int? statusCode, String? statusMessage, String? errorMessage}) {
    return ResponseAuthInfoMedExt(
      model: data != null ? AuthInfoMedExt.fromMap(data) : null,
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}