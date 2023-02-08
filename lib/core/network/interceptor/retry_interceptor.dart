import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as sm;
import 'package:get/instance_manager.dart';

import 'package:medicinadireta/core/failures/external_failure_error.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/logs/controller/debug_view_controller.dart';
import 'package:medicinadireta/modules/logs/debug_log_item.dart';
import 'package:medicinadireta/routes/app_pages.dart';

import 'dio_connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({required this.requestRetrier});
  final _controller = Get.find<DebugViewController>();

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    _controller.addLog(DebugLogItem.fromRes(code: response.statusCode ?? 0, requestOptions: response.requestOptions, data: response.data));
    Map<String, dynamic> _onResponse = {
      "_METHOD": response.requestOptions.method,
      "_ENDPOINT": response.requestOptions.path,
      "_BASE_URL": response.requestOptions.baseUrl,
      "_HEADERS": response.requestOptions.headers,
      // "_DATA": response.data,
      "DATA": response.data != null && response.data.toString().length >= 320 ? response.data.toString().substring(1, 320) : "---",
    };

    AppLog.s("$_onResponse", name: "_onResponse");

    return super.onResponse(response, handler);
  }

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    _controller.addLog(DebugLogItem.fromReq(requestOptions: options));

    Map<String, dynamic> _onRequest = {
      "_METHOD": options.method,
      "_ENDPOINT": options.path,
      "_BASE_URL": options.baseUrl,
      "_DATA": options.data,
      "_HEADERS": options.headers,
      "_QUERY": options.queryParameters,
    };
    AppLog.w("$_onRequest", name: "_onRequest");

    return super.onRequest(options, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    _controller.addLog(DebugLogItem.fromError(requestOptions: err.requestOptions, err: err));

    Map<String, dynamic> _onError = {
      "METHOD": err.requestOptions.method,
      "PATH": err.requestOptions.path,
      "BASE_URL": err.requestOptions.baseUrl,
      "STATUS_CODE": err.response?.statusCode,
      "STATUS_MESSAGE": err.response?.statusMessage,
      "CONNECTIMEOUT": err.requestOptions.connectTimeout,
      "QUERY_PARAMETRES": err.requestOptions.queryParameters.toString(),
      "HEADERS": err.requestOptions.headers.toString(),
      "DATA": err.requestOptions.data,
      "ERROR DATA": err.response?.data,
    };

    AppLog.d("$_onError", name: "_onError");
    var isPathAuth = err.requestOptions.path == '/Seguranca';
    String day = DateTime.now().day.toString();
    String reportTag = "DIA:$day-PATH:${err.requestOptions.path}";
    if (!isPathAuth) ExternalFailureError.execute(exception: "$_onError", contexts: "$_onError", reportTag: reportTag);
    if (!isPathAuth && err.response?.statusCode == 401 && err.response?.statusMessage == 'Unauthorized') {
      await refreshToken();
      return super.onError(err, handler);
    }
    if (_shouldRetry(err)) {
      try {
        return requestRetrier.scheduleRequestRetry(err.requestOptions, handler);
      } catch (e) {
        return e;
      }
    }
    return super.onError(err, handler);
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.other && err.error != null && err.error is SocketException;
  }
}

Future<void> refreshToken() async {
  await SharedPreferencesHelper().removeAll();
  sm.Get.toNamed(Routes.AUTH);
}
