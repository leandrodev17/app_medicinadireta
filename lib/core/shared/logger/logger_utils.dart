import 'package:medicinadireta/core/widgets/app_log.dart';

class Logger {
  // Sample of abstract logging function
  static void write(String text, {bool isError = false}) {
    Future.microtask(() => AppLog.w('** $text. isError: [$isError]'));
  }
}
