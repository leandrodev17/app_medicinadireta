import '/core/network/failures/failures.dart';
import '/core/network/failures/failures_generic.dart';
import '/modules/authentication/domain/entities/response_server_authentication.dart';
import '../entities/params_authentication.dart';
import 'package:dartz/dartz.dart';

import '/modules/authentication/domain/repositories/authentication_repository.dart';

import 'authentication_usecase.dart';

class AuthenticationUsecaseImpl implements AuthenticationUsecase {
  final AuthenticationRepository repository;

  AuthenticationUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseServerAuthentication>> authenticationUser(ParamsAuthentication req) async {
    try {
      bool _login = req.login?.isEmpty ?? false;
      bool _pass = req.password?.isEmpty ?? false;
      if (_login || _pass) return left(FailureGeneric(message: 'Dados de login obrigatório'));
      return repository.authenticationRepository(req);
    } catch (e) {
      return left(FailureGeneric(message: 'Dados de login obrigatório'));
    }
  }
}
