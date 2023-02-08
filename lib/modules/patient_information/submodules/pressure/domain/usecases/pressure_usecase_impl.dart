import 'package:dartz/dartz.dart';
import 'package:medicinadireta/modules/patient_information/submodules/pressure/domain/entities/network/pressure_response.dart';

import '../repositories/pressure_repository.dart';
import '/core/network/failures/failures.dart';
import '/core/network/failures/failures_generic.dart';
import 'pressure_usecase.dart';

class PressureUsecaseImpl implements PressureUsecase {
  final PressureRepository repository;

  PressureUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, PressureResponse>> findPressureUsecase(int pacientId) async {
    try {
      if (pacientId == 0) return left(FailureGeneric(message: 'Falha de sistema, não foi possível efetuar a listagem'));
      return repository.findAllPressureRepository(pacientId);
    } catch (e) {
      return left(FailureGeneric(message: 'Falha de sistema, não foi possível efetuar a listagem'));
    }
  }
}
