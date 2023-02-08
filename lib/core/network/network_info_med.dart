import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../constants/const_endpoint.dart';
import 'package:dio/dio.dart';

import 'interceptor/dio_connectivity_request_retrier.dart';
import 'interceptor/retry_interceptor.dart';

class NetworkInfoMed {
  Dio _client;

  NetworkInfoMed(this._client) {
    BaseOptions options = BaseOptions(
      baseUrl: ENDPOINT_INFO_MED,
      sendTimeout: 5000,
      connectTimeout: 5000,
      receiveTimeout: 8000,
      maxRedirects: 1,
      followRedirects: false,
      receiveDataWhenStatusError: true,
    );
    _client.options.sendTimeout = 5000;
    _client.options.connectTimeout = 5000;
    _client.options.receiveTimeout = 8000;
    _client.options.maxRedirects = 1;
    _client.options.followRedirects = false;
    _client.options.receiveDataWhenStatusError = true;
    _client.options.responseType = ResponseType.json;
    _client.options.contentType = 'application/json; charset=utf-8';
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

  Future<Response> post(String url, {Map<String, dynamic>? body, bool isAuth = false}) async {
    try {
      final token = await SharedPreferencesHelper().currentTokenInfoMed;
      Map<String, dynamic> headers = <String, dynamic>{};
      headers[Headers.contentTypeHeader] = Headers.jsonContentType;
      headers[Headers.acceptHeader] = Headers.jsonContentType;
      if (isAuth) headers["Authorization"] = "Bearer $token";
      return await _client.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
    } on DioError catch (er) {
      AppLog.d('POST ERROR: NETWORK STATUS CODE ===> ${er.response!.statusCode}');
      AppLog.d('POST ERROR: NETWORK STATUS MESSAGE ===> ${er.response!.statusMessage}');
      AppLog.d('POST ERROR: NETWORK TYPE ===> ${er.type}');
      var status = er.response!.statusCode;
      var message = er.response!.statusMessage;
      var data = er.response!.data ?? [];
      return Response(requestOptions: er.requestOptions, statusCode: status, statusMessage: message, data: data);
    }
  }

  Future<Response> get(String url, {Map<String, dynamic>? body, Map<String, dynamic>? headers, bool isAuth = true}) async {
    try {
      final token = await SharedPreferencesHelper().currentTokenInfoMed;

      Map<String, dynamic> head = <String, dynamic>{};
      head = headers ?? <String, dynamic>{};

      head[Headers.contentTypeHeader] = Headers.jsonContentType;
      head[Headers.acceptHeader] = Headers.jsonContentType;
      head["Authorization"] = "Bearer $token";

      return await _client.get(
        Uri.encodeFull(url),
        options: Options(headers: head),
        queryParameters: body ?? {},
      );
    } on DioError catch (er) {
      AppLog.d('ERROR: NETWORK STATUS CODE ===> ${er.response!.statusCode}');
      AppLog.d('ERROR: NETWORK STATUS MESSAGE ===> ${er.response!.statusMessage}');
      AppLog.d('ERROR: NETWORK TYPE ===> ${er.type}');
      var statusCode = er.response!.statusCode!.toInt();
      var statusMessage = er.response!.statusMessage.toString();
      var data = er.response!.data ?? [];
      return Response(requestOptions: er.requestOptions, statusCode: statusCode, statusMessage: statusMessage, data: data);
    }
  }
}
