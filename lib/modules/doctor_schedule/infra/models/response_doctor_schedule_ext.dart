import '/modules/doctor_schedule/domain/entities/response_doctor_schedule.dart';
import '/modules/doctor_schedule/infra/models/doctor_schedule_ext.dart';

class ResponseDoctorScheduleExt extends ResponseDoctorSchedule {
  final List<DoctorScheduleExt> model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  final String? odata;

  ResponseDoctorScheduleExt({this.statusCode, this.statusMessage, this.errorMessage, this.odata, required this.model});

  factory ResponseDoctorScheduleExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseDoctorScheduleExt(
      model: data!.map<DoctorScheduleExt>((data) => DoctorScheduleExt.fromMap(data)).toList(),
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      odata: odata,
    );
  }
}
