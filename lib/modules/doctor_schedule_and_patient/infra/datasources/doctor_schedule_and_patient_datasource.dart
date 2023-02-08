import 'package:medicinadireta/core/models/request/headers.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/infra/models/response_doctor_schedule_and_patient_ext.dart';

abstract class DoctorScheduleAndPatientDatasource {
  Future<ResponseDoctorScheduleAndPatientExt> doctorScheduleAndPatientDatasource(QueryParameters req, Headers headers);
}
