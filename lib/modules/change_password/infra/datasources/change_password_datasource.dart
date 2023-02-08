import 'package:medicinadireta/modules/change_password/domain/entities/network/request_change_password.dart';
import 'package:medicinadireta/modules/change_password/infra/models/network/response_change_password_ext.dart';

abstract class ChangePasswordDatasource {
  Future<ResponseChangePasswordExt> saveChangePasswordDatasource(RequestChangePassword req);
}
