
import 'doctor_schedule_and_patient.dart';

class ResponseDoctorScheduleAndPatient {
  final List<DoctorScheduleAndPatient>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseDoctorScheduleAndPatient({this.statusCode, this.statusMessage, this.errorMessage, this.model});
}
