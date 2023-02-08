import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/core/network/failures/failures_generic.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/network/request_communication.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/network/response_communication.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/network/response_communication_sms.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/repositories/communication_repository.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/usecases/communication_usecase.dart';
import 'package:dartz/dartz.dart';

class CommunicationUsecaseImpl implements CommunicationUsecase {
  final CommunicationRepository repository;

  CommunicationUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseCommunication>> saveByCommunication(RequestCommunication params) async {
    try {
      if (params.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.saveCommunicationRepository(params);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

  @override
  Future<Either<Failures, ResponseCommunicationSms>> sendSMSByCommunication(RequestCommunication params) async {
    try {
      if (params.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.sendSMSCommunicationRepository(params);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
