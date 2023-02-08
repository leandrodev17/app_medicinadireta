import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/request_new_phone.dart';
import 'package:medicinadireta/modules/modules_helpers/infra/models/network/response_model_to_mail_ext.dart';
import 'package:medicinadireta/modules/modules_helpers/infra/models/network/response_model_to_sms_ext.dart';
import 'package:medicinadireta/modules/modules_helpers/infra/models/network/response_new_phone_ext.dart';

abstract class ModelToMailDatasource {
  Future<ResponseModelToMailExt> findModelToMailDatasource();
  Future<ResponseModelToSmsExt> findModelToSmsDatasource();
  Future<ResponseNewPhoneExt> saveNewPhoneDatasource(RequestNewPhone request, int patientId);
}
