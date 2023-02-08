import 'package:medicinadireta/modules/infor_med/domain/entities/response_contents_htm_info_med.dart';
import 'package:medicinadireta/modules/infor_med/infra/models/contents_info_med_ext.dart';

class ResponseContentsHTMLInfoMedExt extends ResponseContentsHTMLInfoMed {
  final ContentsInfoMedExt? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseContentsHTMLInfoMedExt({this.statusCode, this.statusMessage, this.errorMessage, required this.model});

  factory ResponseContentsHTMLInfoMedExt.fromMap({ContentsInfoMedExt? data, int? statusCode, String? statusMessage, String? errorMessage}) {
    return ResponseContentsHTMLInfoMedExt(
      model: data != null ? data : null,
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
    );
  }
}
