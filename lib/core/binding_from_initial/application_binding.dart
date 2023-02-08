import 'package:medicinadireta/core/binding_from_initial/commons_controller.dart';
import 'package:medicinadireta/core/controller_from_initial/verification_access_menu_user.dart';
import 'package:medicinadireta/core/info_app/app_device_info_controller.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/modules/logs/controller/debug_view_controller.dart';
import 'package:medicinadireta/modules/patient_information/presenter/controller/patient_datails_controller.dart';
import 'package:get/get.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SharedPreferencesHelper());
    Get.lazyPut(() => AppDeviceInfoController());
    Get.lazyPut(() => PatientDetailsController());
    Get.lazyPut(() => VerificationAccessMenuUser(
          sharedPreferences: Get.find<SharedPreferencesHelper>(),
          deviceInfo: Get.find<AppDeviceInfoController>(),
        ));

    /// TODO acredito que esse controller {CommonsController} não está mais sendo preciso, a ideia era facilitar a comunicao de um valor em várias controller
    Get.lazyPut(() => CommonsController());
  }
}
