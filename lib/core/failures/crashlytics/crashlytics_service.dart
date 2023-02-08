import 'dart:convert';
import 'dart:isolate';

import 'package:medicinadireta/constants/const_strings.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsService {
  static Future<void> initializeFlutterFire() async {
    try {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      Isolate.current.addErrorListener(ErrorReportCrashlytics.isolateErrorListener);
    } catch (e) {
      debugPrint("Problema para inicializarinitializeFlutterFire $e");
    }
  }
}

class ErrorReportCrashlytics {
  static Future<void> _report({
    required dynamic exception,
    required StackTrace stackTrace,
    required String tag,
    required dynamic contexts,
  }) async {
    if (!kDebugMode && exception != null) {
      var id = "--";
      Map<String, dynamic> _map = <String, dynamic>{};
      String? _dataUser = await SharedPreferencesHelper().getDataCurrentAccess;
      if (_dataUser != null && _dataUser != ConstStrings.appValueNull) {
        var _decode = jsonDecode(_dataUser);
        id = _decode["id"].toString();
        if (_decode["id"] != null) _map["id"] = _decode["id"];
        if (_decode["nome"] != null) _map["nome"] = _decode["nome"];
        if (_decode["cpf"] != null) _map["cpf"] = _decode["cpf"];
        if (_decode["email"] != null) _map["email"] = _decode["email"];
        if (_decode["login"] != null) _map["login"] = _decode["login"];
        if (_decode["especialidadeId"] != null) _map["especialidadeId"] = _decode["especialidadeId"];
      }

      debugPrintStack(label: tag, stackTrace: stackTrace);
      await FirebaseCrashlytics.instance.setCustomKey("EXCEPTION_$tag", exception.toString());
      await FirebaseCrashlytics.instance.setCustomKey("DATA_USER", _map.toString());
      await FirebaseCrashlytics.instance.setUserIdentifier(id);
      await FirebaseCrashlytics.instance.setCustomKey("CONTEXTS_PERSONAL_$tag", contexts.toString());
      await FirebaseCrashlytics.instance.log(exception.toString());
      await FirebaseCrashlytics.instance.recordError(exception, stackTrace);
    }
  }

  static void externalFailureError({
    StackTrace? stackTrace,
    String? reportTag,
    dynamic exception,
    dynamic contexts = "NOT_CONTEXTS",
  }) {
    _report(
      stackTrace: stackTrace ?? StackTrace.empty,
      tag: reportTag ?? "EXTERNAL_FAILURE",
      contexts: contexts ?? "NOT_CONTEXTS",
      exception: exception,
    );
  }

  static SendPort get isolateErrorListener {
    return RawReceivePort((pair) {
      final List<dynamic> errorAndStackTrace = pair;
      final exception = errorAndStackTrace[0];
      final stackTrace = errorAndStackTrace[1];
      _report(stackTrace: stackTrace, tag: "ISOLATE_FAILURE", contexts: "--", exception: exception);
    }).sendPort;
  }
}
