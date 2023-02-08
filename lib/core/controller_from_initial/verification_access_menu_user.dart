import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:medicinadireta/constants/const_strings.dart';
import 'package:medicinadireta/core/enum/paper_access_user.dart';
import 'package:medicinadireta/core/info_app/app_device_info_controller.dart';
import 'package:medicinadireta/modules/authentication/infra/models/response_authentication_access.dart';
import 'package:get/get.dart';

import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/websocket/signal_websocket.dart';

class VerificationAccessMenuUser extends GetxController {
  final SharedPreferencesHelper sharedPreferences;
  final AppDeviceInfoController deviceInfo;

  VerificationAccessMenuUser({required this.sharedPreferences, required this.deviceInfo});

  final RxMap<String, ResponseAuthenticationAccess> _accessDataUser = RxMap<String, ResponseAuthenticationAccess>();

  final String _private = 'S';

  final name = ''.obs;
  final avatar = ''.obs;

  final RxString? versionApp = RxString('');

  @override
  void onInit() async {
    // _appDevice();
    // _accessDataUser.clear();
    // await _loadingAccessUser();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  appDevice() async {
    String? _version;
    String? _buildNumber;
    try {
      Map<String, dynamic>? _map = await deviceInfo.getPackageInfo();
      _version = _map?["version"] ?? null;
      _buildNumber = _map?["buildNumber"] ?? null;
      // if (_version != null && _buildNumber != null)
      versionApp?.value = "$_version ($_buildNumber)";
    } catch (e, s) {
      AppLog.d("Falha ao ler informação da device", stackTrace: s, name: '_appDevice');
    }
  }

  userDataInfo() async {
    try {
      final _response = await sharedPreferences.getNameUser;
      var _name = '';
      var _avatar = '';
      if (_response != null) {
        var _nameVetor = _response.split(' ');
        if (_nameVetor.length > 1) {
          var _firstLetter = _nameVetor[0].substring(0, 1).toUpperCase();
          var _secondLetter = _nameVetor[1].substring(0, 1).toUpperCase();
          _avatar = "$_firstLetter$_secondLetter";
          _name = "${_nameVetor[0]} ${_nameVetor[1]}";
        } else {
          var _firstLetter = _nameVetor[0].substring(0, 1).toUpperCase();
          var _secondLetter = _nameVetor[0].substring(1, 2).toUpperCase();
          _avatar = "$_firstLetter$_secondLetter";
          _name = "${_nameVetor[0]}";
        }
        name.value = _name;
        avatar.value = _avatar;
      }
    } catch (e) {
      AppLog.d('Não foi possível ler as informações do usuário $e', name: 'userDataInfo');
    }
  }

  loadingAccessUser() async {
    try {
      _accessDataUser.clear();
      final _response = await sharedPreferences.getCurrentAccessAplication;
      if (_response != null && _response != ConstStrings.appValueNull) {
        List<dynamic> _decode = json.decode(_response.toString());
        _decode.forEach((element) {
          var _item = ResponseAuthenticationAccess.fromMap(element);
          // _accessDataUser.update(_item.aplicativo!, (value) => _item);
          _accessDataUser[_item.aplicativo!] = _item;
        });
        await userDataInfo();
      }
    } catch (e) {
      AppLog.d('Não foi possível ler os dados de acessos $e', name: 'loadingAccessUser');
    }
  }

  // Existe menu de acesso
  bool existsKeyMenu(String key) {
    var _key = key.replaceAll('/', '');
    var _existsKeyMenu = _accessDataUser.containsKey(_key);
    if (_existsKeyMenu) return true;
    return false;
  }

  // Se o valor for igual "S" tem permissão
  bool accessPaper(String key, PaperAccessUser papper) {
    var _key = key.replaceAll('/', '');
    var _existsKeyMenu = _accessDataUser.containsKey(_key);
    // AppLog.w('_key $_existsKeyMenu $_key $papper');
    if (_existsKeyMenu) {
      String _value;
      var _item = _accessDataUser[_key];
      // AppLog.w('_item ${_item?.toMap()}');
      switch (papper) {
        case PaperAccessUser.PRIVATE_ACCESS:
          _value = _item?.privateAccess ?? '';
          break;
        case PaperAccessUser.PRIVATE_INSERT:
          _value = _item?.privateInsert ?? '';
          break;
        case PaperAccessUser.PRIVATE_DELETE:
          _value = _item?.privateDelete ?? '';
          break;
        case PaperAccessUser.PRIVATE_UPDATE:
          _value = _item?.privateUpdate ?? '';
          break;
        case PaperAccessUser.PRIVATE_EXPORT:
          _value = _item?.privateExport ?? '';
          break;
        case PaperAccessUser.PRIVATE_PRINT:
          _value = _item?.privatePrint ?? '';
          break;
        default:
          _value = '';
      }
      // AppLog.d('_value $_value $_private');
      // AppLog.d('_value ${_value == _private}');
      if (_value != '' && _value == _private) return true;
      return false;
    }
    return false;
  }

  Future<void> logout() async {
    try {
      // SignalWebsocket.instance.openConnection;
      SharedPreferences.getInstance()
          .then((r) async {
            bool result = await r.clear();
            // debugPrint('result $result');
            if (result) Get.toNamed(Routes.AUTH);
          })
          .catchError((e) {
            AppLog.w('Não foi possível remover a sessão de login $e', name: 'logoutRemocao');
          })
          .timeout(const Duration(seconds: 2))
          .whenComplete(() => debugPrint('completo'));
    } catch (e) {
      AppLog.d('Não foi possível fazer logout $e', name: 'logout');
    }
  }

  final RxString infoLogin = RxString('');
  void dataUserShow() async {
    try {
      String? _dataUser = await sharedPreferences.getDataCurrentAccess;
      if (_dataUser != null && _dataUser != ConstStrings.appValueNull) {
        name.value = '';
        infoLogin.value = '';
        var _decode = jsonDecode(_dataUser);
        if (_decode["nome"] != null) name.value = _decode["nome"];
        if (_decode["login"] != null) infoLogin.value = _decode["login"];
      }
    } catch (e) {
      AppLog.d('Problema para exibir os dados do usuário no card de menu $e', name: 'logout');
    }
  }
}
