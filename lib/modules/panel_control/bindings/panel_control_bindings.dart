import 'package:medicinadireta/modules/panel_control/presenter/controller/panel_control_controller.dart';
import 'package:get/get.dart';

class PanelControlBindings implements Bindings {
@override
void dependencies() {
    Get.put(PanelControlController());
}
}