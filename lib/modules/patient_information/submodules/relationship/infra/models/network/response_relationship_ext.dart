import 'package:medicinadireta/modules/patient_information/submodules/relationship/domain/entities/network/response_relationship.dart';

class ResponseRelationshipExt extends ResponseRelationship {
  final dynamic model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  final String? odata;

  ResponseRelationshipExt({this.statusCode, this.statusMessage, this.errorMessage, this.odata, required this.model});

  factory ResponseRelationshipExt.fromMap({dynamic data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseRelationshipExt(
      model: data,
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      odata: odata,
    );
  }
}