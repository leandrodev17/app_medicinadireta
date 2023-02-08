
import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/reschedule_committed/domain/entities/network/request_reschedule_default.dart';
import 'package:medicinadireta/modules/reschedule_committed/infra/datasource/reschedule_datasource.dart';
import 'package:medicinadireta/modules/reschedule_committed/infra/models/network/response_reschedule_ext.dart';

class RescheduleDatasourceImpl implements RescheduleDatasource {
  final Network _network;
  RescheduleDatasourceImpl(this._network);

  @override
  Future<ResponseRescheduleExt> saveRescheduleDatasource(RequestRescheduleDefault parameters, int novoAgendamentoId) async {
    try {
      final response = await _network.post(AppUrl.reschudeleApi(novoAgendamentoId), body: parameters, isAuth: true);
      AppLog.d(response.toString(),name: 'saveRescheduleDatasource');
      if (response.data == null || response.statusCode == null) {
        return ResponseRescheduleExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
      }

      return ResponseRescheduleExt.fromMap(statusCode: response.statusCode, statusMessage: response.statusMessage, data: response.data);
    } catch (e, s) {
      AppLog.d('Não foi possível enviar os dados para o servidor $e', name: 'saveRescheduleDatasource', stackTrace: s);
      return ResponseRescheduleExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
    }
  }

  @override
  Future<ResponseRescheduleExt> saveRescheduleSnapDatasource(RequestRescheduleDefault parameters, int novoAgendamentoId) async {
    try {
      final response = await _network.post(AppUrl.rescheduleSnapApi(novoAgendamentoId), body: parameters, isAuth: true);
      AppLog.d(response.toString(),name: 'saveRescheduleSnapDatasource');
      AppLog.d(parameters.toMap().toString(),name: 'saveRescheduleSnapDatasource Para');
      // AppLog.d(response.toString());
      if (response.data == null || response.statusCode == null) {
        return ResponseRescheduleExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
      }
      return ResponseRescheduleExt.fromMap(statusCode: response.statusCode, statusMessage: response.statusMessage, data: response.data);
    } catch (e, s) {
      AppLog.d('Não foi possível enviar os dados para o servidor $e', name: 'saveRescheduleDatasource', stackTrace: s);
      return ResponseRescheduleExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
    }
  }
}
