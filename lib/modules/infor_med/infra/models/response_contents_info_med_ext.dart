import 'package:medicinadireta/modules/infor_med/domain/entities/response_contents_info_med.dart';
import 'package:medicinadireta/modules/infor_med/infra/models/contents_info_med_ext.dart';

class ResponseContentsInfoMedExt extends ResponseContentsInfoMed {
  final List<ContentsInfoMedExt>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseContentsInfoMedExt({this.statusCode, this.statusMessage, this.errorMessage, required this.model});

  factory ResponseContentsInfoMedExt.fromMap({dynamic data, int? statusCode, String? statusMessage, String? errorMessage}) {
    return ResponseContentsInfoMedExt(
      model: data?.map<ContentsInfoMedExt>((data) => ContentsInfoMedExt.fromMap(data)).toList() ?? [],
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
