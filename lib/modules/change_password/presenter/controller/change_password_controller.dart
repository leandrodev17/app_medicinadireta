import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/change_password/domain/entities/network/request_change_password.dart';
import 'package:medicinadireta/modules/change_password/external/datasource/change_password_datasource_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final ChangePasswordDatasourceImpl requestServer;
  final SharedPreferencesHelper sharedPreferences;
  ChangePasswordController({required this.requestServer, required this.sharedPreferences});

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  final RxBool loading = RxBool(false);

  final RxBool visiblePasswordNew = RxBool(false);
  void visiblePasswordShow() => visiblePasswordNew.value = !visiblePasswordNew.value;

  final RxString newPassword = RxString('null');
  void setNewPassword(String? value) => newPassword.value = value!;
  bool get validErrorNewPasswordEmpty => newPassword.value != 'null' && newPassword.value.isNotEmpty;
  String? get newPasswordError {
    if (newPassword.value == 'null' || validErrorNewPasswordEmpty) return null;
    return 'requiredField'.tr;
  }

  final RxString confirmPassword = RxString('null');
  void setConfirmPassword(String? value) => confirmPassword.value = value!;
  bool get validErrorConfirmPasswordEmpty => confirmPassword.value != 'null' && (confirmPassword.value == newPassword.value);
  String? get confirmPasswordError {
    if (confirmPassword.value == 'null' || validErrorConfirmPasswordEmpty) {
      return null;
    } else if (confirmPassword.value != newPassword.value) {
       return 'Senhas diferentes'.tr;
    }
    return 'requiredField'.tr;
  }

  bool get isPressedSave => validErrorNewPasswordEmpty && validErrorConfirmPasswordEmpty;

  saveNewPassword() async {
    try {
      loading.value = true;
      await 1.delay();
      final req = RequestChangePassword(novaSenha: newPassword.toString().toUpperCase(), confirmarNovaSenha: confirmPassword.toString().toUpperCase());
      final response = await requestServer.saveChangePasswordDatasource(req);
      loading.value = false;
      if (response.statusCode != 200) {
        loading.value = false;
        await AppAlert.alertWarning(title: 'Oops!', body: response.statusMessage ?? 'Não foi possível alterar senha', seconds: 10);
        return;
      }
      if (response.model != null) {
        loading.value = false;
        await AppAlert.alertSuccess(title: "Sucesso!", body: "Alteração com sucesso!");
        return;
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
      AppLog.d('Não foi possível alterar a senha $e', name:  'saveNewPassword');
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
