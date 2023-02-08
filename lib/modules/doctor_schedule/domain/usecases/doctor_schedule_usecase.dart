import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/doctor_schedule/domain/entities/response_doctor_schedule.dart';

import '/core/network/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class DoctorScheduleUsecase {
  Future<Either<Failures, ResponseDoctorSchedule>> doctorScheduleUser(QueryParameters req);
}


