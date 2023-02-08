import 'package:flutter/foundation.dart';

import 'crashlytics/crashlytics_service.dart';

class ExternalFailureError {
  static void execute({
    String? message,
    StackTrace? stackTrace,
    String? reportTag,
    dynamic exception,
    dynamic contexts = "NOT_CONTEXTS",
  }) {
    if (stackTrace != null) debugPrintStack(label: reportTag, stackTrace: stackTrace);
    ErrorReportCrashlytics.externalFailureError(
      contexts: contexts,
      exception: exception,
      reportTag: reportTag,
      stackTrace: stackTrace,
    );
  }
}
