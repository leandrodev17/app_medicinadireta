import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/financial/domain/entities/network/response_financial.dart';
import 'package:medicinadireta/modules/financial/domain/entities/network/response_service_order.dart';

import 'package:dartz/dartz.dart';

abstract class FinancialUsecase {
  Future<Either<Failures, ResponseFinancial>> findByFinancial(QueryParameters parameters);
  Future<Either<Failures, ResponseServiceOrder>> findByServiceOrder(QueryParameters parameters, int patientId);
}
