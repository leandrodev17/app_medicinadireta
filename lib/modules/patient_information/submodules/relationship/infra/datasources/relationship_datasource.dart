import 'package:medicinadireta/modules/patient_information/submodules/relationship/domain/entities/network/request_relationship.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/infra/models/network/response_relationship_ext.dart';

abstract class RelationshipDatasource {
  Future<ResponseRelationshipExt> saveRelationshipDatasource(RequestRelationship req, int pacienteId);
}
