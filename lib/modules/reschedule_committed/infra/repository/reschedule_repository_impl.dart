import 'package:medicinadireta/core/network/failures/datasource_error.dart';
import 'package:medicinadireta/modules/reschedule_committed/domain/entities/network/response_reschedule.dart';
import 'package:medicinadireta/modules/reschedule_committed/domain/entities/network/request_reschedule_default.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/reschedule_committed/domain/repositories/reschedule_repositoy.dart';
import 'package:medicinadireta/modules/reschedule_committed/infra/datasource/reschedule_datasource.dart';
import 'package:dartz/dartz.dart';

class RescheduleRepositoryImpl implements RescheduleRepository {
  final RescheduleDatasource datasource;

  RescheduleRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseReschedule>> saveReschedule(RequestRescheduleDefault parameters, int novoAgendamentoId) async {
    try {
      final result = await datasource.saveRescheduleDatasource(parameters, novoAgendamentoId);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponseReschedule>> saveRescheduleSnap(RequestRescheduleDefault parameters, int novoAgendamentoId) async {
    try {
      final result = await datasource.saveRescheduleSnapDatasource(parameters, novoAgendamentoId);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
