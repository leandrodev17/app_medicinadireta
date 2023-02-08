import '../../../domain/entities/network/anthropometry_response.dart';
import '../anthropometry_model.dart';

class AnthropometryResponseExt extends AnthropometryResponse {
  const AnthropometryResponseExt({statusCode, statusMessage, errorMessage, required model})
      : super(
          model: model,
          errorMessage: errorMessage,
          statusMessage: statusMessage,
          statusCode: statusCode,
        );

  factory AnthropometryResponseExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage}) {
    return AnthropometryResponseExt(
      model: data?.map<AnthropometryModel>((data) => AnthropometryModel.fromMap(data)).toList() ?? [],
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
