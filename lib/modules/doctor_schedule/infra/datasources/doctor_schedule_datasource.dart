import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/doctor_schedule/infra/models/response_doctor_schedule_ext.dart';

abstract class DoctorScheduleDatasource {
  Future<ResponseDoctorScheduleExt> doctorScheduleDatasource(QueryParameters req);
}
