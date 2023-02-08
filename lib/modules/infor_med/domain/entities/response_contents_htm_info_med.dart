import 'contents_info_med.dart';

class ResponseContentsHTMLInfoMed {
  final ContentsInfoMed? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseContentsHTMLInfoMed({this.statusCode, this.statusMessage, this.errorMessage, this.model});
}
