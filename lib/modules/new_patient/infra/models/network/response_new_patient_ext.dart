import 'package:medicinadireta/core/models/patient/patient_model_ext.dart';
import 'package:medicinadireta/modules/new_patient/domain/entities/network/response_new_patient.dart';

class ResponseNewPatientExt extends ResponseNewPatient {
  final PatientModelExt? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  final String? odata;

  ResponseNewPatientExt({this.statusCode, this.statusMessage, this.errorMessage, this.odata, required this.model});

  factory ResponseNewPatientExt.fromMap({Map<String, dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseNewPatientExt(
      model: data != null ? PatientModelExt.fromMap(data) : null,
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      odata: odata,
    );
  }
}
