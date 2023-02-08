import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/response_model_to_mail.dart';
import 'package:medicinadireta/modules/modules_helpers/infra/models/model_to_mail_ext.dart';

class ResponseModelToMailExt extends ResponseModelToMail {
  final List<ModelToMailExt>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  final String? odata;

  ResponseModelToMailExt({this.statusCode, this.statusMessage, this.errorMessage, this.odata, required this.model});

  factory ResponseModelToMailExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseModelToMailExt(
      model: data?.map<ModelToMailExt>((data) => ModelToMailExt.fromMap(data)).toList(),
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      odata: odata,
    );
  }
}
