import 'package:medicinadireta/modules/reschedule_committed/domain/entities/network/response_reschedule.dart';

class ResponseRescheduleExt extends ResponseReschedule {
  final dynamic responseData;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseRescheduleExt({this.statusCode, this.statusMessage, this.errorMessage, this.responseData});

  factory ResponseRescheduleExt.fromMap({dynamic data, int? statusCode, String? statusMessage, String? errorMessage}) {
    return ResponseRescheduleExt(
      responseData: data,
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
