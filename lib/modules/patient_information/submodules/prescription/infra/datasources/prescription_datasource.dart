import 'package:medicinadireta/modules/patient_information/submodules/prescription/infra/models/network/response_prescription_ext.dart';


abstract class PrescriptionDatasource {
  Future<ResponsePrescriptionExt> findAllPrescriptionDatasource(int pacientId);
}
