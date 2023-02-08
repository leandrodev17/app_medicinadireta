import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/change_password/domain/entities/network/response_change_password.dart';
import 'package:medicinadireta/modules/change_password/domain/entities/network/request_change_password.dart';
import 'package:dartz/dartz.dart';

abstract class ChangePasswordRepository {
  Future<Either<Failures, ResponseChangePassword>> saveChangePasswordRepository(RequestChangePassword req);
}
