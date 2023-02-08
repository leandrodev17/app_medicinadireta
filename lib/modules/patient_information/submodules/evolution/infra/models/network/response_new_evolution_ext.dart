import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/response_new_evolution.dart';

class ResponseNewEvolutionExt extends ResponseNewEvolution {
  final dynamic responseData;
  final int? statusCode;
  final String? statusMessage;

  ResponseNewEvolutionExt({this.statusCode, this.statusMessage, this.responseData});

  factory ResponseNewEvolutionExt.fromMap({dynamic data, int? statusCode, String? statusMessage}) {
    return ResponseNewEvolutionExt(responseData: data ?? null, statusCode: statusCode, statusMessage: statusMessage);
  }
}
