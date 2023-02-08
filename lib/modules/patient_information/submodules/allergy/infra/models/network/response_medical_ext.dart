
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/network/response_medical.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/medical_ext.dart';

class ResponseMedicalExt extends ResponseMedical {
  const ResponseMedicalExt({statusCode, statusMessage, errorMessage, required model, dataNewMedical})
      : super(
          model: model,
          errorMessage: errorMessage,
          statusMessage: statusMessage,
          statusCode: statusCode,
          dataNewMedical: dataNewMedical,
        );

  factory ResponseMedicalExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage, dynamic dataNewMedical}) {
    return ResponseMedicalExt(
      model: data?.map<MedicalExt>((data) => MedicalExt.fromMap(data)).toList() ?? [],
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      dataNewMedical: dataNewMedical,
    );
  }
}
