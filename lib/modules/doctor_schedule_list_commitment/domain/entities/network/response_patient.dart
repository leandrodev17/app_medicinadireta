
import 'package:medicinadireta/core/models/phones/patient_model_phone.dart';

class ResponsePatient {
  final List<PatientModelPhone>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponsePatient({this.statusCode, this.statusMessage, this.errorMessage, this.model});
}
