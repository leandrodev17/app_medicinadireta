import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/infra/datasources/exams_datasource.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/infra/models/network/response_exams_ext.dart';

class ExamsDatasourceImpl implements ExamsDatasource {
  final Network _network;
  ExamsDatasourceImpl(this._network);

  @override
  Future<ResponseExamsExt> findAllExamsDatasource(int pacientId, QueryParameters parameters) async {
    try {
      final resp = await _network.get(AppUrl.findAllExamsPatientId(pacientId), isAuth: true, body: parameters);
      if (resp.statusCode == null) {
        return ResponseExamsExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: STATUS_MESSAGE_DEFAULT);
      }
      return ResponseExamsExt.fromMap(statusCode: resp.statusCode, data: resp.data['value'], statusMessage: resp.statusMessage);
    } catch (e) {
      return ResponseExamsExt.fromMap(statusCode: STATUS_CODE_DEFAULT, data: const [], statusMessage: e.toString());
    }
  }
}
