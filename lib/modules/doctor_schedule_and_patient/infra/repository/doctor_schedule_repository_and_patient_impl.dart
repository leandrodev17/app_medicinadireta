import 'package:medicinadireta/core/models/request/headers.dart';
import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/domain/entities/response_doctor_schedule_and_patient.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/domain/repositories/doctor_schedule_and_patient_repository.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/infra/datasources/doctor_schedule_and_patient_datasource.dart';

import '/core/network/failures/datasource_error.dart';
import '/core/network/failures/failures.dart';
import 'package:dartz/dartz.dart';

class DoctorScheduleRepositoryAndPatientImpl implements DoctorScheduleAndPatientRepository {
  final DoctorScheduleAndPatientDatasource datasource;

  DoctorScheduleRepositoryAndPatientImpl(this.datasource);
  @override
  Future<Either<Failures, ResponseDoctorScheduleAndPatient>> doctorScheduleAndPatientRepository(QueryParameters req, Headers headers) async {
    try {
      final result = await datasource.doctorScheduleAndPatientDatasource(req, headers);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
