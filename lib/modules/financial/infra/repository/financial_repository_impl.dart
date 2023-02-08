import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/datasource_error.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/financial/domain/entities/network/response_financial.dart';
import 'package:medicinadireta/modules/financial/domain/entities/network/response_service_order.dart';
import 'package:medicinadireta/modules/financial/domain/repositories/financial_repository.dart';
import 'package:medicinadireta/modules/financial/infra/datasources/financial_datasource.dart';
import 'package:dartz/dartz.dart';

class FinancialRepositoryImpl implements FinancialRepository {
  final FinancialDatasource datasource;

  FinancialRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseFinancial>> findFinancialRepository(QueryParameters parameters) async {
    try {
      final result = await datasource.findFinancialDatasource(parameters);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponseServiceOrder>> findServiceOrderRepository(QueryParameters parameters, int patientId) async{
    try {
      final result = await datasource.findServiceOrderDatasource(parameters, patientId);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
