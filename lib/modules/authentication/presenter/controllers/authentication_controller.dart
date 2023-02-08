import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:medicinadireta/constants/const_strings.dart';
import 'package:medicinadireta/core/alert/app_alert.dart';
import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/push_notification_firebase/push_notification_configure.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/authentication/infra/models/response_authentication_access.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/core/shared/shared_preferences.dart';
import '/modules/authentication/domain/entities/params_authentication.dart';
import '/modules/authentication/external/datasource/authentication_datasource_impl.dart';

class AuthenticationController extends GetxController {
  final AuthenticationDatasourceImpl requestServer;
  final SharedPreferencesHelper sharedPreferences;
  final CheckConnectingNetwork checkConnecting;

  AuthenticationController({required this.requestServer, required this.sharedPreferences, required this.checkConnecting});

  final RxBool loading = RxBool(false);
  final RxBool visiblePassword = RxBool(false);

  void visiblePasswordShow() => visiblePassword.value = !visiblePassword.value;

  Future<String?> _getTokenFirebase() async {
    try {
      String? _token;

      ///Permissões do tipo de SOM, ALERT...
      await PushNotificationConfigure().notificationRequestPermission();

      ///Configuração da notificação local
      await PushNotificationConfigure().initialConfigPushNotification();

      ///Gera um novo token do tipo push notification
      _token = await FirebaseMessaging.instance.getToken();

      if (_token != null) await SharedPreferencesHelper().setCurrentTokenNotification(_token);

      if (_token == null || _token.isEmpty) {
        _token = await SharedPreferencesHelper().currentTokenNotification;
      }
      return _token;
    } catch (e, s) {
      AppLog.d("Problema para buscar dados do motorista $e", name: "_getTokenFirebase", stackTrace: s);
      return null;
    }
  }

  signInUser(ParamsAuthentication dataRequest) async {
    try {
      // String? _tokeNotification;
      bool _isConnected = await checkConnecting.appCheckConnectivity();
      if (!_isConnected) {
        await AppAlert.alertError(title: "Oops!", body: "problema com a conexão, verifique ou tente novamente", seconds: 5);
        loading.value = false;
        return;
      }
      loading.value = true;
      await deleteCache();
      // var _params = ParamsAuthentication(login: username.toString(), password: password.toUpperCase());

      /// Configuração do firebase
      /// Não temos estrutura backend para receber o token e trabalhar envio de push
      // _tokeNotification = await _getTokenFirebase();
      // if (_tokeNotification == null) {
      //   _tokeNotification = await SharedPreferencesHelper().currentTokenNotification;
      // }

      final _response = await requestServer.authenticationDatasource(dataRequest);

      if (_response.statusCode != 200 || _response.model == null) {
        await AppAlert.alertError(title: "Oops!", body: _response.statusMessage ?? '', seconds: 5);
        loading.value = false;
        return;
      }

      // AppLog.w("_response.model ${_response.model?.toMap()}", name: "loginxxxxx");
      String? dataAccess = ConstStrings.appValueNull;

      String? _name = _response.model?.nome ?? ConstStrings.appValueNull;
      String? _utc = _response.model?.utc ?? ConstStrings.appValueNull;
      List<ResponseAuthenticationAccess>? _access = _response.model?.acessos ?? [];
      String? _token = _response.model?.token?.chave ?? ConstStrings.appValueNull;
      DateTime? _duracaoExpire = _response.model?.token?.duracao ?? DateTime.now();
      String? _responseData = _response.model != null ? jsonEncode(_response.model?.toMap()) : ConstStrings.appValueNull;

      if (_access.isNotEmpty) {
        List<Map<String, dynamic>> _map = _access.map((ResponseAuthenticationAccess e) => e.toMap()).toList();
        dataAccess = json.encode(_map);
      }

      var _f1 = sharedPreferences.setCurrentToken(_token);
      var _f2 = sharedPreferences.setNameUser(_name);
      var _f3 = sharedPreferences.setCurrentExpiresToken(_duracaoExpire.toIso8601String());
      var _f4 = sharedPreferences.setCurrentAccessAplication(dataAccess);
      var _f5 = sharedPreferences.setCurrentAccess(_responseData);

      await Future.wait([_f1, _f2, _f3, _f4, _f5]).then((v) => AppLog.w("gravando valor local Token: ${v.toList()}", name: "signInUser"));

      // if (_token != null) await sharedPreferences.setCurrentToken(_token);
      // if (_name != null) await sharedPreferences.setNameUser(_name);
      // if (_duracaoExpire != null) await sharedPreferences.setCurrentExpiresToken(_duracaoExpire.toIso8601String());

      // if (_access.isNotEmpty) {
      //   var _map = _access.map((ResponseAuthenticationAccess e) => e.toMap()).toList();
      //   var _data = json.encode(_map);
      //   await sharedPreferences.setCurrentAccessAplication(_data);
      // }

      // if (_token != null) await sharedPreferences.setCurrentAccess(jsonEncode(_response.model?.toMap()));

      loading.value = false;
      await Get.offNamed(Routes.DOCTOR_ACHEDULE);
    } catch (e) {
      AppLog.d('Falha ao fazer login $e', name: 'signInUser');
      await AppAlert.alertError(title: "Oops!", body: e.toString(), seconds: 15);
      loading.value = false;
    }
  }

  deleteCache() async {
    try {
      SharedPreferences.getInstance()
          .then((r) => r.clear())
          .catchError((e) {
            AppLog.w('Não foi possível remover a sessão de login $e', name: 'logoutRemocao');
          })
          .timeout(Duration(seconds: 2))
          .whenComplete(() => AppLog.s('completo'));

      // var _f = sharedPreferences.removeAll();

      // await Future.wait([_f]).then((v) {
      //   AppLog.w('Remoção com sucesso ${v[0]}', name: 'REMOÇÃO');
      // }).catchError((e) {
      //   AppLog.w('Não foi possível remover o cache $e', name: 'REMOÇÃO');
      // });
    } catch (e) {
      AppLog.d('Falha ao limpar dados do login $e', name: 'deleteCache');
    }
  }

  @override
  void onInit() async {
    // await deleteCache();
    // await sharedPreferences.removeAll();
    // if (kDebugMode) {
    //   username.value = 'sbis53';
    //   password.value = '12345sp';
    //   userController.text = 'sbis53';
    //   passController.text = '12345sp';
    // }
    loading.value = false;
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
