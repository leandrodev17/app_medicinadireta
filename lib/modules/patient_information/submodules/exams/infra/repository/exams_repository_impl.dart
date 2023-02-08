import 'package:dartz/dartz.dart';

import '/core/models/request/query_parameters.dart';
import '/core/network/failures/datasource_error.dart';
import '/core/network/failures/failures.dart';
import '/modules/patient_information/submodules/allergy/domain/entities/network/response_allergy.dart';
import '/modules/patient_information/submodules/allergy/domain/repositories/allergy_repository.dart';
import '/modules/patient_information/submodules/allergy/infra/datasources/allergy_datasource.dart';

class AllergyRepositoryImpl implements AllergyRepository {
  final AllergyDatasource datasource;

  AllergyRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseAllergy>> findAllergysRepository(int pacientId, QueryParameters parameters) async {
    try {
      final result = await datasource.findAllergysDatasource(pacientId, parameters);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
