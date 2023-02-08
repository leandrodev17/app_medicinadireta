import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/financial/infra/models/network/response_financial_ext.dart';
import 'package:medicinadireta/modules/financial/infra/models/network/response_service_order_ext.dart';

abstract class FinancialDatasource {
  Future<ResponseFinancialExt> findFinancialDatasource(QueryParameters parameters);
  Future<ResponseServiceOrderExt> findServiceOrderDatasource(QueryParameters parameters, int patientId);
}
