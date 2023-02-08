import 'package:medicinadireta/core/info_app/app_device_info_controller.dart';
import 'package:medicinadireta/core/network/check_connecting_network.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/routes/app_pages.dart';
import 'package:get/get.dart';

class ForceVersionController extends GetxController {
  final AppDeviceInfoController deviceInfo;
  final CheckConnectingNetwork checkConnecting;
  final Network network;

  ForceVersionController({required this.checkConnecting, required this.network, required this.deviceInfo});

  // Inicializado na chamada da controller
  forceUpdateApp() async {
    final _isForceUpdate = await isForceUpdateApp();
    if (_isForceUpdate) {
      await Get.toNamed(Routes.PAGE_UPDATE_VERSIO_APP);
      return;
    }
  }

  Future<bool> isForceUpdateApp() async {
    try {
      bool _isConnected = await checkConnecting.appCheckConnectivity();
      if (_isConnected) {
        final _server = await findByEnvironmentVariable();
        if (_server != null) {
          final _packageInfo = await deviceInfo.getPackageInfo();
          var _versionInfo = _packageInfo!['buildNumber'] != null ? int.parse(_packageInfo['buildNumber'].toString()) : 1;
          var _versionServer = _server['buildNumber'] != null ? int.parse(_server['buildNumber'].toString()) : 1;
          return _versionServer > _versionInfo;
        }
        return false;
      }
      return false;
    } on Exception catch (e) {
      AppLog.d("Não foi possível validar a regra para atualizar a versão do app instalado $e", name: 'isForceUpdateApp');
      return false;
    }
  }

  // PESQUISAR VARIÁVEIS DE AMBIENTE PARA CONTROLE DA VERSÃO E TRAVA DE GEOLOCALIZAÇÃO.
  Future<Map<String, dynamic>?> findByEnvironmentVariable() async {
    Map<String, dynamic> _map = Map<String, dynamic>();
    try {
      final _response = await network.get(AppUrl.versionCode);
      if (_response.statusCode != null && _response.data != null && _response.statusCode == 200) {
        if (_response.data == null) return null;
        var _version = _response.data['version_code'] ?? null;
        AppLog.i('ENTROU AQUI COM VALORES DO SERVIDOR $_version', name: 'findByEnvironmentVariable');
        _map['buildNumber'] = _version;
        return _map;
      }
      return null;
    } catch (e) {
      AppLog.d("Error: Environment Variable $e", name: 'findByEnvironmentVariable');
      return null;
    }
  }
}
