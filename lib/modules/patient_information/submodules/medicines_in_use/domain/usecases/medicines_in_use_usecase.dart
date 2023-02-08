import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/domain/entities/network/response_medicines.dart';

import 'package:dartz/dartz.dart';

abstract class MedicinesInUseUsecase {
  Future<Either<Failures, ResponseMedicinesInUse>> findByMedicinesInUse(QueryParameters parameters, int patientId);
}
