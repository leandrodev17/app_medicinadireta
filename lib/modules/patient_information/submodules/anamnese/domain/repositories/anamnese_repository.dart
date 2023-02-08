import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/request_new_anamnese.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_anamnese.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_ciap.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_cid_sub_category.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_new_anamnese.dart';
import 'package:dartz/dartz.dart';

abstract class AnamneseRepository {
  Future<Either<Failures, ResponseAnamnese>> findAnamneseRepository(int pacientId, QueryParameters parameters);
  Future<Either<Failures, ResponseNewAnamnese>> saveNewAnamneseRepository(RequestNewAnamnese params, int pacientId);
  Future<Either<Failures, ResponseCiap>> findCiapRepository();
  Future<Either<Failures, ResponseCidSubCategory>> findCidSubCategoryRepository();
}
