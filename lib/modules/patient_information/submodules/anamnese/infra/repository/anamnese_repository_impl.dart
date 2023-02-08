import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/datasource_error.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_anamnese.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_new_anamnese.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/request_new_anamnese.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_cid_sub_category.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_ciap.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/repositories/anamnese_repository.dart';
import 'package:medicinadireta/modules/patient_information/submodules/anamnese/infra/datasources/anamnese_datasource.dart';
import 'package:dartz/dartz.dart';

class AnamneseRepositoryImpl implements AnamneseRepository {
  final AnamneseDatasource datasource;

  AnamneseRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseNewAnamnese>> saveNewAnamneseRepository(RequestNewAnamnese params, int pacientId) async {
    try {
      final result = await datasource.saveNewAnamneseDatasource(params, pacientId);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponseCiap>> findCiapRepository() async {
    try {
      final result = await datasource.findCiapDatasource();
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponseCidSubCategory>> findCidSubCategoryRepository() async {
    try {
      final result = await datasource.findCidSubCategoryDatasource();
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponseAnamnese>> findAnamneseRepository(int pacientId, QueryParameters parameters) async {
    try {
      final result = await datasource.findAnamneseDatasource(pacientId, parameters);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
