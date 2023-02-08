import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_anamnese.dart';

import '../anamnese_ext.dart';

class ResponseAnamneseExt extends ResponseAnamnese {
  final List<AnamneseExt>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  ResponseAnamneseExt({this.statusCode, this.statusMessage, this.errorMessage, required this.model});

  factory ResponseAnamneseExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage}) {
    return ResponseAnamneseExt(
      model: data?.map<AnamneseExt>((data) => AnamneseExt.fromMap(data)).toList() ?? [],
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}