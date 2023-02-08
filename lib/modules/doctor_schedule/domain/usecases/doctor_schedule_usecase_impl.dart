import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/doctor_schedule/domain/entities/response_doctor_schedule.dart';
import 'package:medicinadireta/modules/doctor_schedule/domain/repositories/doctor_schedule_repository.dart';
import 'package:medicinadireta/modules/doctor_schedule/domain/usecases/doctor_schedule_usecase.dart';

import '/core/network/failures/failures.dart';
import '/core/network/failures/failures_generic.dart';
import 'package:dartz/dartz.dart';

class DoctorScheduleUsecaseImpl implements DoctorScheduleUsecase {
  final DoctorScheduleRepository repository;

  DoctorScheduleUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseDoctorSchedule>> doctorScheduleUser(QueryParameters req) async {
    try {
      if (req.props.isEmpty) {
        return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      }
      return repository.doctorScheduleRepository(req);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
