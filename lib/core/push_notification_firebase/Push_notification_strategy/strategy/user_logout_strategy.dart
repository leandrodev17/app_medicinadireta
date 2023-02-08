import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:get/get.dart';

import 'i_push_strategy.dart';

class UserLogoutStrategy implements IPushStrategy {
  @override
  Future<void> execute(Map<String, dynamic> pushPayload) async {
    // Não está rolando em background só em primeiro plano.
    AppLog.w('Entrou no processo de logout em background $pushPayload');
    final shared = SharedPreferencesHelper();
    var _b = shared.removeAll();

    await Future.wait([_b]).then((v) {
      AppLog.w('Remover todas sessões com a solicitaçao de logout ${v[0]} ${v[0]}');
      if (v[0]) Get.offAllNamed(Routes.AUTH);
      // if (v[0]) Modular.to.pushReplacementNamed(ConstPages.PAGE_HOME);
    }).catchError((e) {
      AppLog.d('Error ao tentar zerar a sessão $e');
    }).timeout(const Duration(seconds: 2));
    var _token = await shared.currentToken;
    AppLog.w('_token $_token');
  }
}
