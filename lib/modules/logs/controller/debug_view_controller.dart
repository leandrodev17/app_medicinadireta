import 'package:flutter/material.dart';
import 'package:medicinadireta/modules/logs/debug_log_item.dart';

class DebugViewController extends ChangeNotifier {
  final ValueNotifier<List<DebugLogItem>> listLog = ValueNotifier<List<DebugLogItem>>([]);

  addLog(DebugLogItem item) => listLog.value.add(item);
}
