
class ResponseRelationship {
  final dynamic model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

  ResponseRelationship({this.statusCode, this.statusMessage, this.errorMessage, this.model});
}