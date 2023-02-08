import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/response_model_to_sms.dart';
import 'package:medicinadireta/modules/modules_helpers/infra/models/model_to_sms_ext.dart';

class ResponseModelToSmsExt extends ResponseModelToSms {
  final List<ModelToSmsExt>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  final String? odata;

  ResponseModelToSmsExt({this.statusCode, this.statusMessage, this.errorMessage, this.odata, required this.model});

  factory ResponseModelToSmsExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseModelToSmsExt(
      model: data?.map<ModelToSmsExt>((data) => ModelToSmsExt.fromMap(data)).toList(),
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      odata: odata,
    );
  }
}
