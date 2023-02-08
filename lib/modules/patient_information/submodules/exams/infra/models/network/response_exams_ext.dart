import 'package:medicinadireta/modules/patient_information/submodules/exams/domain/entities/network/response_exams.dart';
import 'package:medicinadireta/modules/patient_information/submodules/exams/infra/models/exams_model.dart';



class ResponseExamsExt extends ResponseExams {
  const ResponseExamsExt({statusCode, statusMessage, errorMessage, required model})
      : super(
          model: model,
          errorMessage: errorMessage,
          statusMessage: statusMessage,
          statusCode: statusCode,
        );

  factory ResponseExamsExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage}) {
    return ResponseExamsExt(
      model: data?.map<ExamsModel>((data) => ExamsModel.fromMap(data)).toList() ?? [],
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
