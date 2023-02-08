import 'package:medicinadireta/modules/patient_information/submodules/anamnese/domain/entities/network/response_cid_sub_category.dart';

import '../cid_sub_category_ext.dart';

class ResponseCidSubCategoryExt extends ResponseCidSubCategory {
  final List<CidSubCategoriaExt>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  ResponseCidSubCategoryExt({this.statusCode, this.statusMessage, this.errorMessage, required this.model});

  factory ResponseCidSubCategoryExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage}) {
    return ResponseCidSubCategoryExt(
      model: data?.map<CidSubCategoriaExt>((data) => CidSubCategoriaExt.fromMap(data)).toList() ?? [],
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
