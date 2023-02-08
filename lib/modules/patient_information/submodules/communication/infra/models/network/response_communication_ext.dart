import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/network/response_communication.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/infra/models/communication_ext.dart';

class ResponseCommunicationExt extends ResponseCommunication {
  const ResponseCommunicationExt({super.statusCode, super.statusMessage, super.errorMessage, super.model});

  factory ResponseCommunicationExt.fromMap({dynamic data, int? statusCode, String? statusMessage, String? errorMessage}) {
    return ResponseCommunicationExt(
      model: data != null ? CommunicationExt.fromMap(data) : null,
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
