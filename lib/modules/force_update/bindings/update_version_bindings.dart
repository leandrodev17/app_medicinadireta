import 'package:medicinadireta/modules/force_update/presenter/controller/update_version_app_controller.dart';
import 'package:get/get.dart';

class UpdateVersionBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(UpdateVersionAppController());
  }
}
