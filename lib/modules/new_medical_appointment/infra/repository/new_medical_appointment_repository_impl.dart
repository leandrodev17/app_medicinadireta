import 'package:medicinadireta/core/network/failures/datasource_error.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/request_medical_appointment_schedule_snap.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/response_new_medical_appointment_schedule.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/response_new_medical_appointment_notification.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/request_medical_appointment_schedule.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/request_medical_appointment_notification.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/repositories/new_medical_appointment_repository.dart';
import 'package:medicinadireta/modules/new_medical_appointment/infra/datasources/new_medical_appointment_datasource.dart';
import 'package:dartz/dartz.dart';

class NewMedicalAppointmentRepositoryImpl implements NewMedicalAppointmentRepository {
  final NewMedicalAppointmentDatasource datasource;

  NewMedicalAppointmentRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseNewMedicalAppointmentSchedule>> saveSchedule(RequestNewMedicalAppointmentSchedule parameters, int scheduleId) async {
    try {
      final result = await datasource.saveNewMedicalAppointmentDatasource(parameters, scheduleId);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponseNewMedicalAppointmentSchedule>> saveAppointmentSnap(RequestMedicalAppointmentScheduleSnap parameters)  async {
    try {
      final result = await datasource.saveScheduleSnapDatasource(parameters);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponseNewMedicalAppointmentNotification>> sendNotificationMail(RequestNewMedicalAppointmentNotification parameters) async {
    try {
      final result = await datasource.sendMailAppointmentDatasource(parameters);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponseNewMedicalAppointmentNotification>> sendNotificationSMS(RequestNewMedicalAppointmentNotification parameters) async {
    try {
      final result = await datasource.sendSMSAppointmentDatasource(parameters);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
