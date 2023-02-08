import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/response_new_medical_appointment_notification.dart';
import 'package:medicinadireta/modules/new_medical_appointment/infra/models/new_medical_appointment_notification_ext.dart';

class ResponseNewMedicalAppointmentNotificationExt extends ResponseNewMedicalAppointmentNotification {
  final NewMedicalAppointmentNotificationExt? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  final String? odata;

  ResponseNewMedicalAppointmentNotificationExt({this.statusCode, this.statusMessage, this.errorMessage, this.odata, required this.model});

  factory ResponseNewMedicalAppointmentNotificationExt.fromMap({dynamic data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseNewMedicalAppointmentNotificationExt(
      model: data != null ? NewMedicalAppointmentNotificationExt.fromMap(data) : null,
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      odata: odata,
    );
  }
}