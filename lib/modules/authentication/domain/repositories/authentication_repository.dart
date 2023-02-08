import '/modules/authentication/domain/entities/response_server_authentication.dart';

import '/core/network/failures/failures.dart';
import '../entities/params_authentication.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<Failures, ResponseServerAuthentication>> authenticationRepository(ParamsAuthentication req);
}
