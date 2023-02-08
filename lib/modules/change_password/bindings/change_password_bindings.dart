import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/shared/shared_preferences.dart';
import 'package:medicinadireta/modules/change_password/external/datasource/change_password_datasource_impl.dart';
import 'package:medicinadireta/modules/change_password/presenter/controller/change_password_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ChangePasswordBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(SharedPreferencesHelper());
    Get.put(Network(Get.find<Dio>()));
    Get.put(ChangePasswordDatasourceImpl(Get.find<Network>()));
    Get.put(
      ChangePasswordController(
        requestServer: Get.find<ChangePasswordDatasourceImpl>(),
        sharedPreferences: Get.find<SharedPreferencesHelper>(),
      ),
    );
  }
}