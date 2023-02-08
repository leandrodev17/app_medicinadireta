import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/network/response_forma_farmaceutica.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/forma_farmaceutica_ext.dart';

class ResponseFormaFarmaceuticaExt extends ResponseFormaFarmaceutica {
  const ResponseFormaFarmaceuticaExt({statusCode, statusMessage, errorMessage, required model})
      : super(
          model: model,
          errorMessage: errorMessage,
          statusMessage: statusMessage,
          statusCode: statusCode,
        );

  factory ResponseFormaFarmaceuticaExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage}) {
    return ResponseFormaFarmaceuticaExt(
      model: data?.map<FormaFarmaceuticaExt>((data) => FormaFarmaceuticaExt.fromMap(data)).toList() ?? [],
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
