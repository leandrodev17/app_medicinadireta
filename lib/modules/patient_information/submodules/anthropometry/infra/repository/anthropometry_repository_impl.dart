import 'package:dartz/dartz.dart';

import '../../domain/repositories/anthropometry_repository.dart';
import '../datasources/anthropometry_datasource.dart';
import '../models/network/anthropometry_response_ext.dart';
import '/core/network/failures/datasource_error.dart';
import '/core/network/failures/failures.dart';

class AnthropometryRepositoryImpl implements AnthropometryRepository {
  final AnthropometryDatasource datasource;

  AnthropometryRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, AnthropometryResponseExt>> findAllAnthropometryRepository(int pacientId) async {
    try {
      final result = await datasource.findAllAnthropometryDatasource(pacientId);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
