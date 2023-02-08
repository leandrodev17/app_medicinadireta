import '../patient_products_model_new_evolution.dart';

class ResponsePatientProductsModelNewEvolution {
  final List<PatientProductsModelNewEvolution>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponsePatientProductsModelNewEvolution({this.statusCode, this.statusMessage, this.errorMessage, this.model});
}
