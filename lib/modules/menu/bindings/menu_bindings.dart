import 'package:medicinadireta/core/info_app/app_device_info_controller.dart';
import 'package:get/get.dart';

class MenuBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AppDeviceInfoController());
  }
}
