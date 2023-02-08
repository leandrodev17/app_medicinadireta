import 'package:medicinadireta/core/network/failures/datasource_error.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/new_patient/domain/entities/network/request_new_patient.dart';
import 'package:medicinadireta/modules/new_patient/domain/entities/network/response_new_patient.dart';
import 'package:medicinadireta/modules/new_patient/domain/repositories/new_patient_repository.dart';
import 'package:medicinadireta/modules/new_patient/infra/datasources/new_patient_datasource.dart';
import 'package:dartz/dartz.dart';

class NewPatientRepositoryImpl implements NewPatientRepository {
  final NewPatientDatasource datasource;

  NewPatientRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseNewPatient>> saveNewPatientRepository(RequestNewPatient params) async {
    try {
      final result = await datasource.saveNewPatientDatasource(params);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
