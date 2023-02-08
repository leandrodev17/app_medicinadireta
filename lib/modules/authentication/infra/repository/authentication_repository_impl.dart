import '/modules/authentication/domain/entities/params_authentication.dart';
import '/modules/authentication/domain/entities/response_server_authentication.dart';

import '/core/network/failures/datasource_error.dart';
import '/core/network/failures/failures.dart';
import '/modules/authentication/domain/repositories/authentication_repository.dart';
import '/modules/authentication/infra/datasources/authentication_datasource.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDatasource datasource;

  AuthenticationRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseServerAuthentication>> authenticationRepository(ParamsAuthentication req) async {
    try {
      final result = await datasource.authenticationDatasource(req);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
