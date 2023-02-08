import 'package:dartz/dartz.dart';

import '../../domain/repositories/pressure_repository.dart';
import '../datasources/pressure_datasource.dart';
import '../models/network/pressure_response_ext.dart';
import '/core/network/failures/datasource_error.dart';
import '/core/network/failures/failures.dart';

class PressureRepositoryImpl implements PressureRepository {
  final PressureDatasource datasource;

  PressureRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, PressureResponseExt>> findAllPressureRepository(int pacientId) async {
    try {
      final result = await datasource.findAllPressureDatasource(pacientId);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
