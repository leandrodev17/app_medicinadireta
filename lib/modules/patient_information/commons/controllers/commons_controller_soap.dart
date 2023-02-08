import 'dart:convert';

import 'package:get/state_manager.dart';

import '../../../../constants/const_strings.dart';
import '../../../../core/helpers/formats_datetime.dart';
import '../../../../core/shared/shared_preferences.dart';

class CommonsControllerSoap extends GetxController {
  int _index = 99999;

  final RxInt isExpandedIndex = RxInt(99999);
  final RxInt storageUserId = RxInt(0);

  void Function(int, bool)? expansionCallback(int index, bool isExpanded) {
    isExpandedIndex.value = isExpanded ? _index : index;
    return null;
  }

  loadInfoUserStorage() async {
    String? data = await SharedPreferencesHelper().getDataCurrentAccess;
    if (data != null && data != ConstStrings.appValueNull) {
      var user = jsonDecode(data);
      storageUserId.value = user["id"];
    }
  }

  bool isEdit({int? userId, String? edit}) {
    try {
      if (userId == null || edit == null) return false;
      if (storageUserId.value != 0 && edit == "S" && userId == storageUserId.value) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  String dateFormat(String? dataLocal) {
    try {
      if (dataLocal == null) return "--";
      DateTime dateTime = DateTime.parse(dataLocal.toString());
      String formatDate = FormatsDatetime.formatDate(dateTime, FormatsDatetime.dateHourFormat);
      return formatDate;
    } catch (e) {
      return "--";
    }
  }
}
