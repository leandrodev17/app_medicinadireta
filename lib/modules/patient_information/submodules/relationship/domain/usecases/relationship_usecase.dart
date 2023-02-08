import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/domain/entities/network/request_relationship.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/domain/entities/network/response_relationship.dart';
import 'package:dartz/dartz.dart';

abstract class RelationshipUsecase {
  Future<Either<Failures, ResponseRelationship>> saveRelationship(RequestRelationship req, int pacienteId);
}
