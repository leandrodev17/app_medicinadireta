class ResponsePrincipalActive {
  final List<dynamic>? data;
  final int? statusCode;
  final String? statusMessage;
  ResponsePrincipalActive({this.data, this.statusCode, this.statusMessage});
  factory ResponsePrincipalActive.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage}) {
    return ResponsePrincipalActive(
      data: data,
      statusCode: statusCode,
      statusMessage: statusMessage,
    );
  }
}
