import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/modules/doctor_schedule/domain/repositories/doctor_schedule_repository.dart';
import 'package:medicinadireta/modules/doctor_schedule/infra/datasources/doctor_schedule_datasource.dart';
import 'package:medicinadireta/modules/doctor_schedule/infra/models/response_doctor_schedule_ext.dart';

import '/core/network/failures/datasource_error.dart';
import '/core/network/failures/failures.dart';
import 'package:dartz/dartz.dart';

class DoctorScheduleRepositoryImpl implements DoctorScheduleRepository {
  final DoctorScheduleDatasource datasource;

  DoctorScheduleRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseDoctorScheduleExt>> doctorScheduleRepository(QueryParameters req) async {
    try {
      final result = await datasource.doctorScheduleDatasource(req);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
