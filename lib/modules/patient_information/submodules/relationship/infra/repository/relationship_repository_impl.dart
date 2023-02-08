import 'package:medicinadireta/core/network/failures/datasource_error.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/domain/entities/network/request_relationship.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/domain/entities/network/response_relationship.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/domain/repositories/relationship_repository.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/infra/datasources/relationship_datasource.dart';

import 'package:dartz/dartz.dart';

class RelationshipRepositoryImpl implements RelationshipRepository {
  final RelationshipDatasource datasource;

  RelationshipRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseRelationship>> saveRelationshipRepository(RequestRelationship req, int pacienteId) async {
    try {
      final result = await datasource.saveRelationshipDatasource(req, pacienteId);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
