import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/network/request_communication.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/infra/models/network/response_communication_ext.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/infra/models/network/response_communication_sms_ext.dart';

abstract class CommunicationDatasource {
  Future<ResponseCommunicationExt> saveCommunicationDatasource(RequestCommunication params);
  Future<ResponseCommunicationSmsExt> sendSMSCommunicationDatasource(RequestCommunication params);
}
