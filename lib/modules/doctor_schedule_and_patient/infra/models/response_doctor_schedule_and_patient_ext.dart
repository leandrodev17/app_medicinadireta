import 'package:medicinadireta/modules/doctor_schedule_and_patient/domain/entities/response_doctor_schedule_and_patient.dart';
import 'doctor_schedule_and_patient_ext.dart';

class ResponseDoctorScheduleAndPatientExt extends ResponseDoctorScheduleAndPatient {
  final List<DoctorScheduleAndPatientExt> model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseDoctorScheduleAndPatientExt({this.statusCode, this.statusMessage, this.errorMessage, required this.model});

  factory ResponseDoctorScheduleAndPatientExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseDoctorScheduleAndPatientExt(
      model: data!.map<DoctorScheduleAndPatientExt>((data) => DoctorScheduleAndPatientExt.fromMap(data)).toList(),
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
