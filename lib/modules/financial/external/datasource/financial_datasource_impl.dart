import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/modules/financial/infra/datasources/financial_datasource.dart';
import 'package:medicinadireta/modules/financial/infra/models/network/response_financial_ext.dart';
import 'package:medicinadireta/modules/financial/infra/models/network/response_service_order_ext.dart';

class FinancialDatasourceImpl implements FinancialDatasource {
  final Network _network;
  FinancialDatasourceImpl(this._network);

  @override
  Future<ResponseFinancialExt> findFinancialDatasource(QueryParameters parameters) async {
    final response = await _network.get(AppUrl.patient, body: parameters);
    if (response.statusCode != 200) {
      var _statusMessage = response.statusMessage;
      var _statusCode = response.statusCode;
      return ResponseFinancialExt.fromMap(statusCode: _statusCode, statusMessage: _statusMessage, data: null);
    }
    return ResponseFinancialExt.fromMap(statusCode: response.statusCode, data: response.data['value'] ?? null);
  }

  @override
  Future<ResponseServiceOrderExt> findServiceOrderDatasource(QueryParameters parameters, int patientId) async {
    final response = await _network.get(AppUrl.getPayments(patientId), body: parameters);
    if (response.statusCode != 200) {
      var _statusMessage = response.statusMessage;
      var _statusCode = response.statusCode;
      return ResponseServiceOrderExt.fromMap(statusCode: _statusCode, statusMessage: _statusMessage, data: null);
    }
    return ResponseServiceOrderExt.fromMap(statusCode: response.statusCode, data: response.data['value'] ?? null);
  }
}
