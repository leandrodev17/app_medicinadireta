import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/core/network/failures/failures_generic.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/domain/entities/network/params_general_data.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/domain/entities/network/response_general_data.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/domain/repositories/general_data_repository.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/domain/usecases/general_data_usecase.dart';
import 'package:dartz/dartz.dart';

class GeneralDataUsecaseImpl implements GeneralDataUsecase {
  final GeneralDataRepository repository;

  GeneralDataUsecaseImpl(this.repository);
  
  @override
  Future<Either<Failures, ResponseGeneralData>> saveGeneralData(ParamsGeneralData req, int patientId) async {
    try {
      if (req.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.saveGeneralDataRepository(req, patientId);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

  @override
  Future<Either<Failures, ResponseGeneralData>> findByGeneralData(int patientId, QueryParameters queryParameters) async {
    try {
      return repository.findGeneralDataRepository(patientId, queryParameters);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
