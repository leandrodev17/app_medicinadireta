import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/request_new_anamnese.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_anamnese.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_new_anamnese.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_ciap.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_cid_sub_category.dart';

import 'package:dartz/dartz.dart';

abstract class AnamneseUsecase {
  Future<Either<Failures, ResponseAnamnese>> findByAnamnese(int pacientId, QueryParameters parameters);
  Future<Either<Failures, ResponseNewAnamnese>> saveByNewAnamnese(RequestNewAnamnese params, int pacientId);
  Future<Either<Failures, ResponseCiap>> findByCiap();
  Future<Either<Failures, ResponseCidSubCategory>> findByCiapSubCategory();
}
