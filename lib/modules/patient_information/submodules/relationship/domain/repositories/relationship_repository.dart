import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/domain/entities/network/request_relationship.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/domain/entities/network/response_relationship.dart';
import 'package:dartz/dartz.dart';

abstract class RelationshipRepository {
  Future<Either<Failures, ResponseRelationship>> saveRelationshipRepository(RequestRelationship req, int pacienteId);
}
