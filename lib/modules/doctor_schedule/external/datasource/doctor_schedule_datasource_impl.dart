import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';

import '/core/urls_modules/app_url.dart';
import '/modules/doctor_schedule/infra/datasources/doctor_schedule_datasource.dart';
import '/modules/doctor_schedule/infra/models/response_doctor_schedule_ext.dart';

import '/core/network/network.dart';

class DoctorScheduleDatasourceImpl implements DoctorScheduleDatasource {
  final Network _network;
  DoctorScheduleDatasourceImpl(this._network);

  @override
  Future<ResponseDoctorScheduleExt> doctorScheduleDatasource(QueryParameters req) async {
    try {
      final response = await _network.get(AppUrl.scheduleConfig, body: req);
      if (response.statusCode == null) return ResponseDoctorScheduleExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: [], statusMessage: STATUS_MESSAGE_DEFAULT);
      var _statusMessage = response.statusMessage ?? STATUS_MESSAGE_DEFAULT;
      var _statusCode = response.statusCode ?? STATUS_CODE_DEFAULT;
      return ResponseDoctorScheduleExt.fromMap(statusCode: _statusCode, statusMessage: _statusMessage, data: response.data['value'] ?? []);
    } catch (e) {
      return ResponseDoctorScheduleExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: [], statusMessage: STATUS_MESSAGE_DEFAULT);
    }
  }
}
