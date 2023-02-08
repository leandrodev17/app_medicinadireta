
import 'package:medicinadireta/core/models/patient/patient_model_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/domain/entities/network/response_general_data.dart';

class ResponseGeneralDataExt extends ResponseGeneralData {
  final PatientModelExt? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  final String? odata;

  ResponseGeneralDataExt({this.statusCode, this.statusMessage, this.errorMessage, this.odata, required this.model});

  factory ResponseGeneralDataExt.fromMap({Map<String, dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseGeneralDataExt(
      model: data != null ? PatientModelExt.fromMap(data) : null,
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      odata: odata,
    );
  }
}