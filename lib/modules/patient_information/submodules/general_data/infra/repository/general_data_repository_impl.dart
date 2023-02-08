import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/datasource_error.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/domain/entities/network/params_general_data.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/domain/entities/network/response_general_data.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/domain/repositories/general_data_repository.dart';
import 'package:medicinadireta/modules/patient_information/submodules/general_data/infra/datasources/general_data_datasource.dart';

import 'package:dartz/dartz.dart';

class GeneralDataRepositoryImpl implements GeneralDataRepository {
  final GeneralDataDatasource datasource;

  GeneralDataRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseGeneralData>> findGeneralDataRepository(int patientId, QueryParameters queryParameters) async {
    try {
      final result = await datasource.findGeneralDataDatasource(patientId,queryParameters);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponseGeneralData>> saveGeneralDataRepository(ParamsGeneralData req, int patientId) async {
    try {
      final result = await datasource.saveGeneralDataDatasource(req, patientId);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
