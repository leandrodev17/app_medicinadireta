import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_ciap.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/infra/models/ciap_ext.dart';

class ResponseCiapExt extends ResponseCiap {
  final List<CiapExt>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  ResponseCiapExt({this.statusCode, this.statusMessage, this.errorMessage, required this.model});

  factory ResponseCiapExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage}) {
    return ResponseCiapExt(
      model: data?.map<CiapExt>((data) => CiapExt.fromMap(data)).toList() ?? [],
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
