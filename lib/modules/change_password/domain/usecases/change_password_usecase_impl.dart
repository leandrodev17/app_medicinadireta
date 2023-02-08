import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/core/network/failures/failures_generic.dart';
import 'package:medicinadireta/modules/change_password/domain/entities/network/response_change_password.dart';
import 'package:medicinadireta/modules/change_password/domain/entities/network/request_change_password.dart';
import 'package:medicinadireta/modules/change_password/domain/repositories/change_password_repository.dart';
import 'package:medicinadireta/modules/change_password/domain/usecases/change_password_usecase.dart';
import 'package:dartz/dartz.dart';

class ChangePasswordUsecaseImpl implements ChangePasswordUsecase {
  final ChangePasswordRepository repository;

  ChangePasswordUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseChangePassword>> saveChangePassword(RequestChangePassword req) async {
    try {
      if (req.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.saveChangePasswordRepository(req);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
