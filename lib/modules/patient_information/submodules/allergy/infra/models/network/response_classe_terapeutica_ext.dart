
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/network/response_classe_terapeutica.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/classe_terapeutica_ext.dart';

class ResponseClasseTerapeuticaExt extends ResponseClasseTerapeutica {
  const ResponseClasseTerapeuticaExt({statusCode, statusMessage, errorMessage, required model})
      : super(
          model: model,
          errorMessage: errorMessage,
          statusMessage: statusMessage,
          statusCode: statusCode,
        );

  factory ResponseClasseTerapeuticaExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage}) {
    return ResponseClasseTerapeuticaExt(
      model: data?.map<ClasseTerapeuticaExt>((data) => ClasseTerapeuticaExt.fromMap(data)).toList() ?? [],
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}