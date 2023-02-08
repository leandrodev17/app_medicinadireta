import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/response_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/models/evolution_ext.dart';

class ResponseEvolutionExt extends ResponseEvolution {
  final List<EvolutionExt>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  final String? odata;

  ResponseEvolutionExt({this.statusCode, this.statusMessage, this.errorMessage, this.odata, required this.model});

  factory ResponseEvolutionExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseEvolutionExt(
      model: data != null ? data.map<EvolutionExt>((data) => EvolutionExt.fromMap(data)).toList() : [],
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      odata: odata,
    );
  }
}