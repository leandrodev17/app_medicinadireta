import '/core/network/failures/failures.dart';
import '/modules/authentication/domain/entities/response_server_authentication.dart';
import '/modules/authentication/domain/entities/params_authentication.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationUsecase {
  Future<Either<Failures, ResponseServerAuthentication>> authenticationUser(ParamsAuthentication req);
}


