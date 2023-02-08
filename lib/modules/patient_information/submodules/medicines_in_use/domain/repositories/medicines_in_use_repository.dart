import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/domain/entities/network/response_medicines.dart';
import 'package:dartz/dartz.dart';

abstract class MedicinesInUseRepository {
  Future<Either<Failures, ResponseMedicinesInUse>> findMedicinesInUseRepository(QueryParameters parameters, int patientId);
}
