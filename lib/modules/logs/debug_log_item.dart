import 'package:dio/dio.dart';

class DebugLogItem {
  final String? type;
  final String? method;
  final String? path;
  final String? baseUrl;
  final String? body;
  final String? dataPost;
  final String? headers;
  final String? statusCode;

  final String? errorStatusMessage;
  final String? queryParameters;

  DebugLogItem({
    this.type,
    this.method,
    this.path,
    this.baseUrl,
    this.body,
    this.headers,
    this.statusCode,
    this.errorStatusMessage,
    this.queryParameters,
    this.dataPost,
  });

  static List<MapEntry<String, String>> _formatDataFields(dynamic data) {
    List<MapEntry<String, String>> _formData = <MapEntry<String, String>>[];
    if (data != null) {
      try {
        _formData = List<MapEntry<String, String>>.from(data);
      } catch (e) {
        _formData = <MapEntry<String, String>>[];
      }
    }
    return _formData;
  }

  static DebugLogItem fromReq({required RequestOptions requestOptions}) {
    List<MapEntry<String, String>> fields = _formatDataFields(requestOptions.data);
    return DebugLogItem(
      type: "REQUISIÇÃO",
      baseUrl: requestOptions.baseUrl,
      dataPost: fields.toList().toString(),
      headers: requestOptions.headers.toString(),
      method: requestOptions.method,
      path: requestOptions.path,
      queryParameters: requestOptions.queryParameters.toString(),
    );
  }

  static DebugLogItem fromRes({required RequestOptions requestOptions, required int code, dynamic data}) {
    return DebugLogItem(
      type: "RESPONSE",
      baseUrl: requestOptions.baseUrl,
      body: data != null ? data.toString() : "",
      headers: requestOptions.headers.toString(),
      method: requestOptions.method,
      path: requestOptions.path,
      statusCode: code.toString(),
    );
  }

  static DebugLogItem fromError({required RequestOptions requestOptions, required DioError err}) {
    List<MapEntry<String, String>> fields = _formatDataFields(err.requestOptions.data);
    return DebugLogItem(
        type: "ERROR RESPONSE",
        baseUrl: requestOptions.baseUrl,
        body: err.response?.data.toString(),
        dataPost: fields.toList().toString(),
        headers: requestOptions.headers.toString(),
        method: requestOptions.method,
        path: requestOptions.path,
        statusCode: err.response?.statusCode.toString(),
        queryParameters: requestOptions.queryParameters.toString(),
        errorStatusMessage: err.response?.statusMessage.toString());
  }
}