import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

class AppDeviceInfoController extends GetxController {
  Future<Map<String, dynamic>?> getPackageInfo() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      Map<String, dynamic> _packageInfo = Map<String, dynamic>();

      final String appName = packageInfo.appName;
      final String packageName = packageInfo.packageName;
      final String version = packageInfo.version;
      final String buildNumber = packageInfo.buildNumber;

      _packageInfo["appName"] = appName;
      _packageInfo["packageName"] = packageName;
      _packageInfo["version"] = version;
      _packageInfo["buildNumber"] = buildNumber;
      AppLog.i("Environment Variable $_packageInfo", name: 'getPackageInfo');
      return _packageInfo;
    } catch (e) {
      AppLog.d("Error: Environment Variable $e", name: 'getPackageInfo');
      return null;
    }
  }

  Future<Map<String, dynamic>?> appDeviceInfoPlugin() async {
    try {
      DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        IosDeviceInfo _iosDeviceInfo = await _deviceInfo.iosInfo;
        var _map = _readIosDeviceInfo(_iosDeviceInfo);
        print('iosDeviceInfo $_map');
        return _map;
      } else if (Platform.isAndroid) {
        AndroidDeviceInfo _androidDeviceInfo = await _deviceInfo.androidInfo;
        var _map = _readAndroidBuildData(_androidDeviceInfo);
        AppLog.w(_map.toString(), name: 'androidDeviceInfo');
        return _map;
      }
      return null;
    } catch (e) {
      AppLog.d("Não foi possível identificar o ID ÚNICO DA DEVICE $e", name: 'appDeviceInfoPlugin');
      return null;
    }
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId, // 7a11f49e2acccb38
      //'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor, //AA6045E5-484B-4F31-A6AD-7B53BE5E6B48
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}
