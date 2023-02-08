import 'package:medicinadireta/core/models/patient/patient_model_ext.dart';
import 'package:medicinadireta/modules/financial/domain/entities/network/response_financial.dart';

class ResponseFinancialExt extends ResponseFinancial {
  final List<PatientModelExt>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  final String? odata;

  ResponseFinancialExt({this.statusCode, this.statusMessage, this.errorMessage, this.odata, required this.model});

  factory ResponseFinancialExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseFinancialExt(
      model: data != null ? data.map<PatientModelExt>((data) => PatientModelExt.fromMap(data)).toList():null,
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      odata: odata,
    );
  }
}