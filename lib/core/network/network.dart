import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:medicinadireta/core/failures/external_failure_error.dart';

import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';

import 'interceptor/dio_connectivity_request_retrier.dart';
import 'interceptor/retry_interceptor.dart';
import 'network_request.dart';

class Network {
  Dio _client;

  Network(this._client) {
    BaseOptions options = BaseOptions(
      connectTimeout: 120000,
      receiveTimeout: 120000,
      responseType: ResponseType.json,
      contentType: 'application/json;odata.metadata=minimal;odata.streaming=true',
    );
    _client.options.connectTimeout = 120000;
    _client.options.receiveTimeout = 120000;
    _client.options.responseType = ResponseType.json;
    _client.options.contentType = 'application/json;odata.metadata=minimal;odata.streaming=true';

    _client = Dio(options);

    _client.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: Dio(),
          connectivity: Connectivity(),
        ),
      ),
    );
  }

  Future<Response> post(String url, {NetworkRequest? body, bool isAuth = false, showServiceToast = true}) async {
    try {
      Response<dynamic> response;
      final token = await SharedPreferencesHelper().currentToken;
      Map<String, dynamic> headersApp = <String, dynamic>{};
      headersApp[Headers.contentTypeHeader] = Headers.jsonContentType;
      headersApp[Headers.acceptHeader] = Headers.jsonContentType;
      if (isAuth) headersApp["Authorization"] = "Bearer $token";

      response = await _client.post(url, data: body?.toMap(), options: Options(headers: headersApp)).then(
        (v) => v,
        onError: (er) {
          Map<String, dynamic> onErrorData = {
            "onErrorData": er.toString(),
            "METHOD": er.requestOptions.method,
            "PATH": er.requestOptions.path,
            "BASE_URL": er.requestOptions.baseUrl,
            "STATUS_CODE": er.response?.statusCode,
            "STATUS_MESSAGE": er.response?.statusMessage,
            "CONNECTIMEOUT": er.requestOptions.connectTimeout,
            "QUERY_PARAMETRES": er.requestOptions.queryParameters.toString(),
            "HEADERS": er.requestOptions.headers.toString(),
            "DATA": er.requestOptions.data,
            "ERROR DATA": er.response?.data,
          };

          AppLog.d("$onErrorData", name: "onErrorPOST");
          ExternalFailureError.execute(exception: "$onErrorData", reportTag: "onErrorPOST");
          return Response(
            requestOptions: er.requestOptions,
            statusCode: er.response?.statusCode,
            statusMessage: er.response?.statusMessage,
            data: er.response?.data,
          );
        },
      );
      return response;
    } on DioError catch (er) {
      var statusCode = er.response?.statusCode;
      var statusMessage = er.response?.statusMessage;
      var dataResponse = er.response?.data ?? [];
      return Response(requestOptions: er.requestOptions, statusCode: statusCode, statusMessage: statusMessage, data: dataResponse);
    }
  }

  Future<Response> get(String url, {NetworkRequest? body, NetworkRequest? headers, bool isAuth = true}) async {
    try {
      Response<dynamic> response;

      final token = await SharedPreferencesHelper().currentToken;

      Map<String, dynamic> headersApp = <String, dynamic>{};
      headersApp = headers != null ? headers.toMap() : <String, dynamic>{};

      headersApp[Headers.contentTypeHeader] = Headers.jsonContentType;
      headersApp[Headers.acceptHeader] = Headers.jsonContentType;
      headersApp["Authorization"] = "Bearer $token";

      response = await _client
          .get(
        Uri.encodeFull(url),
        options: Options(headers: headersApp),
        queryParameters: body != null ? body.toMap() : {},
      )
          .then(
        (v) => v,
        onError: (er) {
          Map<String, dynamic> onErrorData = {
            "onErrorData": er.toString(),
            "METHOD": er.requestOptions.method,
            "PATH": er.requestOptions.path,
            "BASE_URL": er.requestOptions.baseUrl,
            "STATUS_CODE": er.response?.statusCode,
            "STATUS_MESSAGE": er.response?.statusMessage,
            "CONNECTIMEOUT": er.requestOptions.connectTimeout,
            "QUERY_PARAMETRES": er.requestOptions.queryParameters.toString(),
            "HEADERS": er.requestOptions.headers.toString(),
            "DATA": er.requestOptions.data,
            "ERROR DATA": er.response?.data,
          };

          AppLog.d("$onErrorData", name: "onErrorGET");
          ExternalFailureError.execute(exception: "$onErrorData", reportTag: "onErrorGET");

          return Response(
            requestOptions: er.requestOptions,
            statusCode: er.response?.statusCode,
            statusMessage: er.response?.statusMessage,
            data: er.response?.data,
          );
        },
      );
      return response;
    } on DioError catch (er) {
      int? statusCode = er.response?.statusCode;
      String? statusMessage = er.response?.statusMessage.toString();
      dynamic dataResponse = er.response?.data ?? [];
      return Response(requestOptions: er.requestOptions, statusCode: statusCode, statusMessage: statusMessage, data: dataResponse);
    }
  }

  Future<Response> put(String url, {NetworkRequest? body}) async {
    try {
      Response<dynamic> response;
      final token = await SharedPreferencesHelper().currentToken;
      Map<String, dynamic> headersApp = <String, dynamic>{};
      headersApp[Headers.contentTypeHeader] = Headers.jsonContentType;
      headersApp[Headers.acceptHeader] = Headers.jsonContentType;
      headersApp["Authorization"] = "Bearer $token";
      response = await _client.put(url, data: body?.toMap(), options: Options(headers: headersApp)).then(
        (v) => v,
        onError: (er) {
          Map<String, dynamic> onErrorData = {
            "onErrorData": er.toString(),
            "METHOD": er.requestOptions.method,
            "PATH": er.requestOptions.path,
            "BASE_URL": er.requestOptions.baseUrl,
            "STATUS_CODE": er.response?.statusCode,
            "STATUS_MESSAGE": er.response?.statusMessage,
            "CONNECTIMEOUT": er.requestOptions.connectTimeout,
            "QUERY_PARAMETRES": er.requestOptions.queryParameters.toString(),
            "HEADERS": er.requestOptions.headers.toString(),
            "DATA": er.requestOptions.data,
            "ERROR DATA": er.response?.data,
          };

          AppLog.d("$onErrorData", name: "onErrorPUT");
          ExternalFailureError.execute(exception: "$onErrorData", reportTag: "onErrorPUT");
          return Response(
            requestOptions: er.requestOptions,
            statusCode: er.response?.statusCode,
            statusMessage: er.response?.statusMessage,
            data: er.response?.data,
          );
        },
      );
      return response;
    } on DioError catch (er) {
      int? statusCode = er.response?.statusCode;
      String? statusMessage = er.response?.statusMessage.toString();
      dynamic dataResponse = er.response?.data ?? [];
      return Response(requestOptions: er.requestOptions, statusCode: statusCode, statusMessage: statusMessage, data: dataResponse);
    }
  }

  Future<Response> delete(String url, {NetworkRequest? body}) async {
    try {
      Response<dynamic> response;
      final token = await SharedPreferencesHelper().currentToken;
      Map<String, dynamic> headersApp = <String, dynamic>{};
      headersApp[Headers.contentTypeHeader] = Headers.jsonContentType;
      headersApp[Headers.acceptHeader] = Headers.jsonContentType;
      headersApp["Authorization"] = "Bearer $token";
      response = await _client.delete(url, data: body?.toMap(), options: Options(headers: headersApp)).then(
        (v) => v,
        onError: (er) {
          Map<String, dynamic> onErrorData = {
            "onErrorData": er.toString(),
            "METHOD": er.requestOptions.method,
            "PATH": er.requestOptions.path,
            "BASE_URL": er.requestOptions.baseUrl,
            "STATUS_CODE": er.response?.statusCode,
            "STATUS_MESSAGE": er.response?.statusMessage,
            "CONNECTIMEOUT": er.requestOptions.connectTimeout,
            "QUERY_PARAMETRES": er.requestOptions.queryParameters.toString(),
            "HEADERS": er.requestOptions.headers.toString(),
            "DATA": er.requestOptions.data,
            "ERROR DATA": er.response?.data,
          };

          AppLog.d("$onErrorData", name: "onErrorDELETE");
          ExternalFailureError.execute(exception: "$onErrorData", reportTag: "onErrorDELETE");
          return Response(
            requestOptions: er.requestOptions,
            statusCode: er.response?.statusCode,
            statusMessage: er.response?.statusMessage,
            data: er.response?.data,
          );
        },
      );
      return response;
    } on DioError catch (er) {
      int? statusCode = er.response?.statusCode;
      String? statusMessage = er.response?.statusMessage.toString();
      dynamic dataResponse = er.response?.data ?? [];
      return Response(requestOptions: er.requestOptions, statusCode: statusCode, statusMessage: statusMessage, data: dataResponse);
    }
  }
}
