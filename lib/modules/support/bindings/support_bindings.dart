import 'package:medicinadireta/modules/support/presenter/controller/support_controller.dart';
import 'package:get/get.dart';

class SupportBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SupportController());
  }
}