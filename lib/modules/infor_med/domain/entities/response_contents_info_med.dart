import 'contents_info_med.dart';

class ResponseContentsInfoMed {
  final List<ContentsInfoMed>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseContentsInfoMed({this.statusCode, this.statusMessage, this.errorMessage, this.model});
}
