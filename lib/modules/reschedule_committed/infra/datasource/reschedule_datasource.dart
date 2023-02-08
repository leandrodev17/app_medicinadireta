import 'package:medicinadireta/modules/reschedule_committed/domain/entities/network/request_reschedule_default.dart';
import 'package:medicinadireta/modules/reschedule_committed/infra/models/network/response_reschedule_ext.dart';

abstract class RescheduleDatasource {
  Future<ResponseRescheduleExt> saveRescheduleDatasource(RequestRescheduleDefault parameters, int novoAgendamentoId);
  Future<ResponseRescheduleExt> saveRescheduleSnapDatasource(RequestRescheduleDefault parameters, int novoAgendamentoId);
}
