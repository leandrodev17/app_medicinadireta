import 'package:dartz/dartz.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anthropometry/domain/entities/network/anthropometry_response.dart';

import '../repositories/anthropometry_repository.dart';
import '/core/network/failures/failures.dart';
import '/core/network/failures/failures_generic.dart';
import 'anthropometry_usecase.dart';

class AnthropometryUsecaseImpl implements AnthropometryUsecase {
  final AnthropometryRepository repository;

  AnthropometryUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, AnthropometryResponse>> findAnthropometryUsecase(int pacientId) async {
    try {
      if (pacientId == 0) return left(FailureGeneric(message: 'Falha de sistema, não foi possível efetuar a listagem'));
      return repository.findAllAnthropometryRepository(pacientId);
    } catch (e) {
      return left(FailureGeneric(message: 'Falha de sistema, não foi possível efetuar a listagem'));
    }
  }
}
