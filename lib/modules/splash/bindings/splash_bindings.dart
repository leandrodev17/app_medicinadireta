import 'package:get/get.dart';
import '../presenter/controller/splash_controller.dart';

class SplashBindings implements Bindings {
  @override
  void dependencies() {
    // Get.put(SharedPreferencesHelper());
    Get.put(SplashController(
      // shared: Get.find<SharedPreferencesHelper>(),
    ));
  }
}
