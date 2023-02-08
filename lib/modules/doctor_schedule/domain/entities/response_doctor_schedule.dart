import 'package:medicinadireta/modules/doctor_schedule/infra/models/doctor_schedule_ext.dart';

class ResponseDoctorSchedule {
  final List<DoctorScheduleExt>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseDoctorSchedule({this.statusCode, this.statusMessage, this.errorMessage, this.model});
}
