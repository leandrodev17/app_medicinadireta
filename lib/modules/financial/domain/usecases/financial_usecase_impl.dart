import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/core/network/failures/failures_generic.dart';
import 'package:medicinadireta/modules/financial/domain/entities/network/response_financial.dart';
import 'package:medicinadireta/modules/financial/domain/entities/network/response_service_order.dart';
import 'package:medicinadireta/modules/financial/domain/repositories/financial_repository.dart';
import 'package:medicinadireta/modules/financial/domain/usecases/financial_usecase.dart';
import 'package:dartz/dartz.dart';

class FinancialUsecaseImpl implements FinancialUsecase {
  final FinancialRepository repository;

  FinancialUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseFinancial>> findByFinancial(QueryParameters parameters) async{
    try {
      if (parameters.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.findFinancialRepository(parameters);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

  @override
  Future<Either<Failures, ResponseServiceOrder>> findByServiceOrder(QueryParameters parameters, int patientId) async {
    try {
      if (parameters.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.findServiceOrderRepository(parameters, patientId);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
