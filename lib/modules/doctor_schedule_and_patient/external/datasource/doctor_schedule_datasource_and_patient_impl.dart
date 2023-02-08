import 'package:medicinadireta/core/models/request/headers.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/infra/datasources/doctor_schedule_and_patient_datasource.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/infra/models/response_doctor_schedule_and_patient_ext.dart';

import '/core/urls_modules/app_url.dart';

import '/core/network/network.dart';

class DoctorScheduleDatasourceAndPatientImpl implements DoctorScheduleAndPatientDatasource {
  final Network _network;
  DoctorScheduleDatasourceAndPatientImpl(this._network);

  @override
  Future<ResponseDoctorScheduleAndPatientExt> doctorScheduleAndPatientDatasource(QueryParameters req, Headers headers) async {
    final response = await _network.get(AppUrl.schedule, body: req, headers: headers);
    if (response.statusCode != 200) {
      var _statusMessage = response.statusMessage;
      var _statusCode = response.statusCode;
      return ResponseDoctorScheduleAndPatientExt.fromMap(statusCode: _statusCode, statusMessage: _statusMessage, data: null);
    }
    return ResponseDoctorScheduleAndPatientExt.fromMap(statusCode: response.statusCode, data: response.data['value'] ?? []);
  }
}
