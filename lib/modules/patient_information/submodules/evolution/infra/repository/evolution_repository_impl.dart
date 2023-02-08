import 'package:medicinadireta/core/models/request/headers.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/datasource_error.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/params_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/request_new_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/response_new_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/entities/network/response_patient_products_model_new_evolution.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/domain/repositories/evolution_repository.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/datasources/evolution_datasource.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/models/network/response_evolution_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/evolution/infra/models/network/response_patient_products_new_evolution_ext.dart';

import 'package:dartz/dartz.dart';

class EvolutionRepositoryImpl implements EvolutionRepository {
  final EvolutionDatasource datasource;

  EvolutionRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseEvolutionExt>> evolutionRepository(ParamsEvolution req, int patientId) async {
    try {
      final result = await datasource.evolutionDatasource(req, patientId);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
  @override
  Future<Either<Failures, ResponsePatientProductsNewEvolutionExt>> patientProductsRepository(QueryParameters req, Headers head) async {
    try {
      final result = await datasource.patientProductsDatasource(req, head);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponsePatientProductsModelNewEvolution>> patientProductsModelRepository() async {
    try {
      final result = await datasource.patientProductsModelDatasource();
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponseNewEvolution>> saveNewEvolution(RequestNewEvolution req, int patientId) async {
    try {
      final result = await datasource.saveNewEvolutionDatasource(req, patientId);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponseNewEvolution>> updateNewEvolution(RequestNewEvolution req, int evolutionId) async {
    try {
      final result = await datasource.updateNewEvolutionDatasource(req, evolutionId);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
