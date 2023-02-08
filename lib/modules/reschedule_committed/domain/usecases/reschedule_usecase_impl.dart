import 'package:medicinadireta/core/network/failures/failures_generic.dart';
import 'package:medicinadireta/modules/reschedule_committed/domain/entities/network/response_reschedule.dart';
import 'package:medicinadireta/modules/reschedule_committed/domain/entities/network/request_reschedule_default.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/reschedule_committed/domain/repositories/reschedule_repositoy.dart';
import 'package:medicinadireta/modules/reschedule_committed/domain/usecases/reschedule_usecase.dart';
import 'package:dartz/dartz.dart';

class RescheduleUsecaseImpl implements RescheduleUsecase {
  final RescheduleRepository repository;

  RescheduleUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseReschedule>> saveByRescheduleSnap(RequestRescheduleDefault parameters, int novoAgendamentoId) async {
    try {
      if (parameters.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.saveRescheduleSnap(parameters, novoAgendamentoId);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

  @override
  Future<Either<Failures, ResponseReschedule>> saveByReschedule(RequestRescheduleDefault parameters, int novoAgendamentoId) async {
    try {
      if (parameters.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.saveReschedule(parameters, novoAgendamentoId);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
