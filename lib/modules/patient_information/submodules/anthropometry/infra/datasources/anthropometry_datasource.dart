import 'package:medicinadireta/modules/patient_information/submodules/anthropometry/infra/models/network/anthropometry_response_ext.dart';

abstract class AnthropometryDatasource {
  Future<AnthropometryResponseExt> findAllAnthropometryDatasource(int pacientId);
}
