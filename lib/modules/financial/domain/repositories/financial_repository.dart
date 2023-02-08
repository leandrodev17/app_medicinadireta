import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/financial/domain/entities/network/response_financial.dart';
import 'package:medicinadireta/modules/financial/domain/entities/network/response_service_order.dart';
import 'package:dartz/dartz.dart';

abstract class FinancialRepository {
  Future<Either<Failures, ResponseFinancial>> findFinancialRepository(QueryParameters parameters);
  Future<Either<Failures, ResponseServiceOrder>> findServiceOrderRepository(QueryParameters parameters, int patientId);
}
