import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/network/response_communication_sms.dart';

import '../communication_sms_ext.dart';

class ResponseCommunicationSmsExt extends ResponseCommunicationSms {
  final ComunicationSmsExt? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseCommunicationSmsExt({this.statusCode, this.statusMessage, this.errorMessage, required this.model});

  factory ResponseCommunicationSmsExt.fromMap({Map<String, dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseCommunicationSmsExt(
      model: data != null ? ComunicationSmsExt.fromMap(data) : null,
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
