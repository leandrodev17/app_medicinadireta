import '/modules/patient_information/submodules/allergy/domain/entities/allergy.dart';
import '/modules/patient_information/submodules/allergy/domain/entities/network/response_allergy.dart';

class ResponseAllergyExt extends ResponseAllergy {
  const ResponseAllergyExt({statusCode, statusMessage, errorMessage, required model})
      : super(
          model: model,
          errorMessage: errorMessage,
          statusMessage: statusMessage,
          statusCode: statusCode,
        );

  factory ResponseAllergyExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage}) {
    return ResponseAllergyExt(
      model: data?.map<Allergy>((data) => Allergy.fromMap(data)).toList() ?? [],
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
