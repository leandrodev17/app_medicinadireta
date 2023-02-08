import 'package:medicinadireta/core/network/failures/datasource_error.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/change_password/domain/entities/network/request_change_password.dart';
import 'package:medicinadireta/modules/change_password/domain/entities/network/response_change_password.dart';
import 'package:medicinadireta/modules/change_password/domain/repositories/change_password_repository.dart';
import 'package:medicinadireta/modules/change_password/infra/datasources/change_password_datasource.dart';

import 'package:dartz/dartz.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ChangePasswordDatasource datasource;

  ChangePasswordRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseChangePassword>> saveChangePasswordRepository(RequestChangePassword req) async{
    try {
      final result = await datasource.saveChangePasswordDatasource(req);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
