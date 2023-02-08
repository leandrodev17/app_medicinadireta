import 'package:medicinadireta/core/models/patient/patient_model.dart';

class ResponseGeneralData {
  final PatientModel? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseGeneralData({this.statusCode, this.statusMessage, this.errorMessage, this.model});
}
