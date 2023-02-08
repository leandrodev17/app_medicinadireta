// import 'dart:convert';
// import 'dart:isolate';

// import 'package:flutter/foundation.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';

class SentryService {
  // static Future<void> initializeSentry() async {
  //   try {
  //     if (!kDebugMode) {
  //       await SentryFlutter.init((options) => options.dsn = SENTRY_DNS);
  //       Isolate.current.addErrorListener(ErrorReportSentry.isolateErrorListener);
  //     }
  //   } catch (e) {
  //     debugPrint("Problema para inicializarinitializeFlutterFire $e");
  //   }
  // }
}

class ErrorReportSentry {
  // static Future<void> _report({
  //   required StackTrace stackTrace,
  //   required String tag,
  //   required dynamic exception,
  //   required dynamic contexts,
  // }) async {
  //   if (!kDebugMode && exception != null) {
  //     var _dataUser = await SharedPreferencesHelper().getCurrentAccess;
  //     String _id = "";
  //     String _mail = "";
  //     String _name = "";
  //     var _decode = _dataUser != null ? jsonDecode(_dataUser) : null;

  //     if (_decode != null) {
  //       _id = _decode["id"] != null ? _decode["id"].toString() : "--";
  //       _mail = _decode["email"] != null ? _decode["email"].toString() : "--";
  //       _name = _decode["name"] != null ? _decode["name"].toString() : "--";
  //     }

  //     // debugPrintStack(label: tag, stackTrace: stackTrace);
  //     Sentry.configureScope((_s) => _s.user = SentryUser(id: '$_id', email: '$_mail', username: '$_name'));
  //     Sentry.configureScope((_d) => _d.setTag(tag, exception.toString()));
  //     Sentry.configureScope((_c) => _c.setContexts('$tag', contexts));
  //     await Sentry.captureException(exception.toString(), stackTrace: stackTrace);
  //   }
  // }

  // static void externalFailureError({
  //   StackTrace? stackTrace,
  //   String? reportTag,
  //   dynamic exception,
  //   dynamic contexts = "NOT_CONTEXTS",
  // }) {
  //   _report(
  //     stackTrace: stackTrace ?? StackTrace.empty,
  //     tag: reportTag ?? "EXTERNAL_FAILURE",
  //     contexts: contexts ?? "NOT_CONTEXTS",
  //     exception: exception ?? null,
  //   );
  // }

  // static SendPort get isolateErrorListener {
  //   return RawReceivePort((pair) {
  //     final List<dynamic> errorAndStackTrace = pair;
  //     final exception = errorAndStackTrace[0];
  //     final stackTrace = errorAndStackTrace[1];
  //     _report(stackTrace: stackTrace, tag: "ISOLATE_FAILURE", contexts: "--", exception: exception);
  //   }).sendPort;
  // }
}
