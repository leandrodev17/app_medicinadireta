import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/reschedule_committed/domain/entities/network/request_reschedule_default.dart';
import 'package:medicinadireta/modules/reschedule_committed/domain/entities/network/response_reschedule.dart';
import 'package:dartz/dartz.dart';

abstract class RescheduleUsecase {
  Future<Either<Failures, ResponseReschedule>> saveByReschedule(RequestRescheduleDefault parameters, int novoAgendamentoId);
  Future<Either<Failures, ResponseReschedule>> saveByRescheduleSnap(RequestRescheduleDefault parameters, int novoAgendamentoId);
}
