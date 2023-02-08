import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  // final SharedPreferencesHelper shared;

  // SplashController({required this.shared});

  @override
  void onInit() {
    redirect();
    super.onInit();
  }

  void redirect() async {
    await Future.delayed(Duration(seconds: 3));
    bool isValidation = await _validationTokenExpiration();
    if (!isValidation) {
      Get.offAllNamed(Routes.AUTH);
      return;
    } else {
      Get.offAllNamed(Routes.DOCTOR_ACHEDULE);
    }
  }

  Future<bool> _validationTokenExpiration() async {
    try {
      String? _expiresToken = await SharedPreferencesHelper().currentExpiresToken ?? null;
      if(_expiresToken != null){
        var _formatDate = DateTime.parse(_expiresToken).millisecondsSinceEpoch;
        var _today = DateTime.now().millisecondsSinceEpoch;
        return _formatDate > _today;
      }
      return false;
    } catch (e) {
      AppLog.d('Falha ao tentar validar Expires Token $e', name: '_validationTokenExpiration');
      return false;
    }
  }
}
