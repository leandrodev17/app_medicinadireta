import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/datasource_error.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/domain/entities/network/response_medicines.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/domain/repositories/medicines_in_use_repository.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/infra/datasources/medicines_in_use_datasource.dart';
import 'package:dartz/dartz.dart';

class MedicinesInUseRepositoryImpl implements MedicinesInUseRepository {
  final MedicinesInUseDatasource datasource;

  MedicinesInUseRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseMedicinesInUse>> findMedicinesInUseRepository(QueryParameters parameters, int patientId) async{
    try {
      final result = await datasource.findMedicinesInUseDatasource(parameters, patientId);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}