import '../../../domain/entities/network/pressure_response.dart';
import '../pressure_model.dart';

class PressureResponseExt extends PressureResponse {
  const PressureResponseExt({statusCode, statusMessage, errorMessage, required model})
      : super(
          model: model,
          errorMessage: errorMessage,
          statusMessage: statusMessage,
          statusCode: statusCode,
        );

  factory PressureResponseExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage}) {
    return PressureResponseExt(
      model: data?.map<PressureModel>((data) => PressureModel.fromMap(data)).toList() ?? [],
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
