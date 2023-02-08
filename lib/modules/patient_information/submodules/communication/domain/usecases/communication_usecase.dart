import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/network/request_communication.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/network/response_communication.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/network/response_communication_sms.dart';

import 'package:dartz/dartz.dart';

abstract class CommunicationUsecase {
  Future<Either<Failures, ResponseCommunication>> saveByCommunication(RequestCommunication params);
  Future<Either<Failures, ResponseCommunicationSms>> sendSMSByCommunication(RequestCommunication params);
}
