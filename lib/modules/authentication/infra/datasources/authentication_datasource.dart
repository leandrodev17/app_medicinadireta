import '/modules/authentication/domain/entities/params_authentication.dart';
import '/modules/authentication/domain/entities/response_server_authentication.dart';

abstract class AuthenticationDatasource {
  Future<ResponseServerAuthentication> authenticationDatasource(ParamsAuthentication req);
}
