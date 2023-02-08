import 'dart:convert';

import 'package:medicinadireta/constants/const_strings.dart';
import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/models/params/params_to_navigation_page.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:get/get.dart';

class MemedController extends GetxController {
  final SharedPreferencesHelper sharedPreferencesHelper;

  final RxInt userId = RxInt(0);
  final RxInt pacientId = RxInt(0);
  final RxBool loadingEmbedded = RxBool(false);

  MemedController(this.sharedPreferencesHelper);

  onInitParams(ParamsToNavigationPage params) {
    print('chamou o oninte');
    _loadDataStorage(params);
  }

  _loadDataStorage(ParamsToNavigationPage params) async {
    try {
      int? _userId;
      loadingEmbedded.value = true;
      await 1.delay();

      String? _data = await SharedPreferencesHelper().getDataCurrentAccess;
      if (_data != null && _data != ConstStrings.appValueNull) {
        var _user = jsonDecode(_data);
        _userId = _user["id"];
      }

      if (_userId != null && params.pacienteId != null) {
        loadingEmbedded.value = false;
        pacientId.value = params.pacienteId!;
        userId.value = _userId;
        return;
      }
      AppAlert.alertWarning(title: "Atenção!", body: 'Não foi possível localizar o usuário, recarregue a tela e tente novamente.', seconds: 25, snackPosition: AppAlert.TOP);
      return;
    } catch (e, s) {
      loadingEmbedded.value = false;
      AppAlert.alertWarning(title: "Atenção!", body: 'Não foi possível localizar o usuário, recarregue a tela e tente novamente.', seconds: 25, snackPosition: AppAlert.TOP);

      AppLog.d("Problema para buscar os dados em memória, $e", name: "_loadDataStorage", stackTrace: s);
    }
  }
}
