import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/modules/contact/external/datasource/contact_datasource_impl.dart';
import 'package:medicinadireta/modules/contact/presenter/controller/contact_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ContactBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(ContactDatasourceImpl(Get.find<Network>()));
    Get.put(
      ContactController(
        Get.find<ContactDatasourceImpl>(),
      ),
    );
  }
}
