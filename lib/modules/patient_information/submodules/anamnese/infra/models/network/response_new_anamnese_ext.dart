import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_new_anamnese.dart';

class ResponseNewAnamneseExt extends ResponseNewAnamnese {
  final dynamic model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  ResponseNewAnamneseExt({this.statusCode, this.statusMessage, this.errorMessage, required this.model});

  factory ResponseNewAnamneseExt.fromMap({dynamic data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseNewAnamneseExt(
      model: null,
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
