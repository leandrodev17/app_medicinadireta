import 'package:medicinadireta/modules/patient_information/submodules/pressure/infra/models/network/pressure_response_ext.dart';

abstract class PressureDatasource {
  Future<PressureResponseExt> findAllPressureDatasource(int pacientId);
}
