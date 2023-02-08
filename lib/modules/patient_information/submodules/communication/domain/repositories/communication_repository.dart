import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/network/request_communication.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/network/response_communication.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/network/response_communication_sms.dart';
import 'package:dartz/dartz.dart';

abstract class CommunicationRepository {
  Future<Either<Failures, ResponseCommunication>> saveCommunicationRepository(RequestCommunication params);
  Future<Either<Failures, ResponseCommunicationSms>> sendSMSCommunicationRepository(RequestCommunication params);
}
