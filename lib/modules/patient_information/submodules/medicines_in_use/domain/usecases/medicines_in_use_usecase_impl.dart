import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/core/network/failures/failures_generic.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/domain/entities/network/response_medicines.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/domain/repositories/medicines_in_use_repository.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/domain/usecases/medicines_in_use_usecase.dart';
import 'package:dartz/dartz.dart';

class MedicinesInUseUsecaseImpl implements MedicinesInUseUsecase {
  final MedicinesInUseRepository repository;

  MedicinesInUseUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseMedicinesInUse>> findByMedicinesInUse(QueryParameters parameters, int patientId) async {
    try {
      if (parameters.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.findMedicinesInUseRepository(parameters, patientId);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
