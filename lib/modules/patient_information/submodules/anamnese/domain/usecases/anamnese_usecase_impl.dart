import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/core/network/failures/failures_generic.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_anamnese.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_new_anamnese.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/request_new_anamnese.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_ciap.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_cid_sub_category.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/repositories/anamnese_repository.dart';
import 'package:dartz/dartz.dart';

import 'anamnese_usecase.dart';

class AnamneseUsecaseImpl implements AnamneseUsecase {
  final AnamneseRepository repository;

  AnamneseUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseNewAnamnese>> saveByNewAnamnese(RequestNewAnamnese params, int pacientId) async {
    try {
      if (params.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.saveNewAnamneseRepository(params, pacientId);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

  @override
  Future<Either<Failures, ResponseCiap>> findByCiap() async {
    try {
      return repository.findCiapRepository();
    } catch (e) {
      return left(FailureGeneric(message: 'Falha de sistema, não foi possível efetuar a listagem'));
    }
  }

  @override
  Future<Either<Failures, ResponseCidSubCategory>> findByCiapSubCategory() async {
    try {
      return repository.findCidSubCategoryRepository();
    } catch (e) {
      return left(FailureGeneric(message: 'Falha de sistema, não foi possível efetuar a listagem'));
    }
  }

  @override
  Future<Either<Failures, ResponseAnamnese>> findByAnamnese(int pacientId, QueryParameters parameters) async {
    try {
      if (pacientId == 0) return left(FailureGeneric(message: 'Falha de sistema, não foi possível efetuar a listagem'));
      return repository.findAnamneseRepository(pacientId, parameters);
    } catch (e) {
      return left(FailureGeneric(message: 'Falha de sistema, não foi possível efetuar a listagem'));
    }
  }
}
