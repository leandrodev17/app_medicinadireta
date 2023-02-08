import 'package:medicinadireta/core/models/phones/patient_model_phone_ext.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/response_patient.dart';

class ResponsePatientExt extends ResponsePatient {
  final List<PatientModelPhoneExt> model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  final String? odata;

  ResponsePatientExt({this.statusCode, this.statusMessage, this.errorMessage, this.odata, required this.model});

  factory ResponsePatientExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponsePatientExt(
      model: data!.map<PatientModelPhoneExt>((data) => PatientModelPhoneExt.fromMap(data)).toList(),
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      odata: odata,
    );
  }
}
