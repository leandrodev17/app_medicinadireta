import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/core/network/failures/failures_generic.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/domain/entities/network/request_relationship.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/domain/entities/network/response_relationship.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/domain/repositories/relationship_repository.dart';
import 'package:medicinadireta/modules/patient_information/submodules/relationship/domain/usecases/relationship_usecase.dart';
import 'package:dartz/dartz.dart';

class RelationshipUsecaseImpl implements RelationshipUsecase {
  final RelationshipRepository repository;

  RelationshipUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseRelationship>> saveRelationship(RequestRelationship req, int pacienteId) async {
    try {
      if (req.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.saveRelationshipRepository(req, pacienteId);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
