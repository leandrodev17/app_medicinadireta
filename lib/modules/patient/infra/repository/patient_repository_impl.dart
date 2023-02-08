import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/datasource_error.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient/domain/entities/network/response_patient.dart';
import 'package:medicinadireta/modules/patient/domain/repositories/patient_repository.dart';
import 'package:medicinadireta/modules/patient/infra/datasources/patient_datasource.dart';
import 'package:dartz/dartz.dart';

class PatientRepositoryImpl implements PatientRepository {
  final PatientDatasource datasource;

  PatientRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponsePatient>> findPatientRepository(QueryParameters parameters) async {
    try {
      final result = await datasource.findPatientDatasource(parameters);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponsePatient>> findPatientIdRepository(QueryParameters parameters, int patientId) async {
    try {
      final result = await datasource.findPatientIdDatasource(parameters, patientId);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
