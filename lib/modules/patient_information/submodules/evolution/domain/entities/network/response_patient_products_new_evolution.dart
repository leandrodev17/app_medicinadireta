
import '../patient_products_new_evolution.dart';

class ResponsePatientProductsNewEvolution {
  final List<PatientProductsNewEvolution>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponsePatientProductsNewEvolution({this.statusCode, this.statusMessage, this.errorMessage, this.model});
}
