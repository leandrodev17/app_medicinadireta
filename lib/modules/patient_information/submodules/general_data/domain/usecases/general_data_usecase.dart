import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/domain/entities/network/params_general_data.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/domain/entities/network/response_general_data.dart';

import 'package:dartz/dartz.dart';

abstract class GeneralDataUsecase {
  Future<Either<Failures, ResponseGeneralData>> findByGeneralData(int patientId, QueryParameters queryParameters);
  Future<Either<Failures, ResponseGeneralData>> saveGeneralData(ParamsGeneralData req, int patientId);
}
