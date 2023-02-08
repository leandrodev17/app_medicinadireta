import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/response_patient_products_model_new_evolution.dart';

import '../patient_products_model_new_evolution_ext.dart';

class ResponsePatientProductsModelNewEvolutionExt extends ResponsePatientProductsModelNewEvolution {
  final List<PatientProductsModelNewEvolutionExt> model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  final String? odata;

  ResponsePatientProductsModelNewEvolutionExt({
    this.statusCode,
    this.statusMessage,
    this.errorMessage,
    this.odata,
    required this.model,
  });

  factory ResponsePatientProductsModelNewEvolutionExt.fromMap({
    List<dynamic>? data,
    int? statusCode,
    String? statusMessage,
    String? errorMessage,
    String? odata,
  }) {
    return ResponsePatientProductsModelNewEvolutionExt(
      model: data!.map<PatientProductsModelNewEvolutionExt>((data) => PatientProductsModelNewEvolutionExt.fromMap(data)).toList(),
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      odata: odata,
    );
  }
}
