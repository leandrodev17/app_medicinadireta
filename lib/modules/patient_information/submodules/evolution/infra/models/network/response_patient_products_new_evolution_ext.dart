import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/response_patient_products_new_evolution.dart';

import '../patient_products_new_evolution_ext.dart';

class ResponsePatientProductsNewEvolutionExt extends ResponsePatientProductsNewEvolution {
  final List<PatientProductsNewEvolutionExt> model;
  final int? statusCode;
  final String? statusMessage;

  ResponsePatientProductsNewEvolutionExt({this.statusCode, this.statusMessage, required this.model});

  factory ResponsePatientProductsNewEvolutionExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage}) {
    return ResponsePatientProductsNewEvolutionExt(
      model: data != null ? data.map<PatientProductsNewEvolutionExt>((data) => PatientProductsNewEvolutionExt.fromMap(data)).toList() : [],
      statusCode: statusCode,
      statusMessage: statusMessage,
    );
  }
}
