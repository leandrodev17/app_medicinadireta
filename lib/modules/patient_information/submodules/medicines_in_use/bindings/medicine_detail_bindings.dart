import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/presenter/controller/medicine_detail_controller.dart';
import 'package:get/get.dart';

class MedicineDetailBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(MedicineDetailController());
  }
}