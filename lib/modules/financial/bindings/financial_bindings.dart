import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/modules/financial/external/datasource/financial_datasource_impl.dart';
import 'package:medicinadireta/modules/financial/presenter/controller/financial_controller.dart';
import 'package:medicinadireta/modules/financial/presenter/controller/service_order_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class FinancialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(Network(Get.find<Dio>()));
    Get.put(FinancialDatasourceImpl(Get.find<Network>()));
    Get.put(FinancialController(
      Get.find<FinancialDatasourceImpl>(),
    ));
    Get.put(ServiceOrderController(
      Get.find<FinancialDatasourceImpl>(),
    ));
  }
}
