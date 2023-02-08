import 'package:medicinadireta/modules/patient_information/submodules/prescription/domain/entities/network/response_prescription.dart';
import 'package:medicinadireta/modules/patient_information/submodules/prescription/infra/models/prescription_model.dart';



class ResponsePrescriptionExt extends ResponsePrescription {
  const ResponsePrescriptionExt({statusCode, statusMessage, errorMessage, required model})
      : super(
          model: model,
          errorMessage: errorMessage,
          statusMessage: statusMessage,
          statusCode: statusCode,
        );

  factory ResponsePrescriptionExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage}) {
    return ResponsePrescriptionExt(
      model: data?.map<PrescriptionModel>((data) => PrescriptionModel.fromMap(data)).toList() ?? [],
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
