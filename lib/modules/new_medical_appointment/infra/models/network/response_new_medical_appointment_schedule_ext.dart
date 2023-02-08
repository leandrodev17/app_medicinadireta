

import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/response_new_medical_appointment_schedule.dart';
import 'package:medicinadireta/modules/new_medical_appointment/infra/models/new_medical_appointment_schedule_ext.dart';

class ResponseNewMedicalAppointmentScheduleExt extends ResponseNewMedicalAppointmentSchedule {
  final NewMedicalAppointmentScheduleExt? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  final String? odata;

  ResponseNewMedicalAppointmentScheduleExt({this.statusCode, this.statusMessage, this.errorMessage, this.odata, required this.model});

  factory ResponseNewMedicalAppointmentScheduleExt.fromMap({dynamic data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseNewMedicalAppointmentScheduleExt(
      model: data != null ? NewMedicalAppointmentScheduleExt.fromMap(data) : null,
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      odata: odata,
    );
  }
}