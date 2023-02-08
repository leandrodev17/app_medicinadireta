import 'package:medicinadireta/core/network/failures/datasource_error.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/params_doctor_commitment.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/params_doctor_commitment_headers.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/network/response_patient.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/repositories/doctor_commitment_repository.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/datasources/doctor_commitment_datasource.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/network/response_doctor_commitment_ext.dart';

import 'package:dartz/dartz.dart';

class DoctorCommitmentRepositoryImpl implements DoctorCommitmentRepository {
  final DoctorCommitmentDatasource datasource;

  DoctorCommitmentRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseDoctorCommitmentExt>> doctorCommitmentRepository(ParamsDoctorCommitment req, ParamsDoctorCommitmentHeaders headers) async {
    try {
      final result = await datasource.doctorCommitmentDatasource(req, headers);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponsePatient>> findPatientRepository(ParamsDoctorCommitment req, int patientId) async {
   try {
      final result = await datasource.patientDatasource(req, patientId);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
