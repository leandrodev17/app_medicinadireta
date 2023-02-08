import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/core/network/failures/failures_generic.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/request_medical_appointment_schedule_snap.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/response_new_medical_appointment_schedule.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/response_new_medical_appointment_notification.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/request_medical_appointment_schedule.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/request_medical_appointment_notification.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/repositories/new_medical_appointment_repository.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/usecases/new_medical_appointment_usecase.dart';
import 'package:dartz/dartz.dart';

class NewMedicalAppointmentUsecaseImpl implements NewMedicalAppointmentUsecase {
  final NewMedicalAppointmentRepository repository;

  NewMedicalAppointmentUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseNewMedicalAppointmentSchedule>> saveBySchedule(RequestNewMedicalAppointmentSchedule parameters, int scheduleId) async {
    try {
      if (parameters.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.saveSchedule(parameters, scheduleId);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

  @override
  Future<Either<Failures, ResponseNewMedicalAppointmentSchedule>> saveByAppointmentSnap(RequestMedicalAppointmentScheduleSnap parameters) async {
    try {
      if (parameters.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.saveAppointmentSnap(parameters);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

  @override
  Future<Either<Failures, ResponseNewMedicalAppointmentNotification>> sendByNotificationMail(RequestNewMedicalAppointmentNotification parameters) async {
    try {
      if (parameters.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.sendNotificationMail(parameters);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

  @override
  Future<Either<Failures, ResponseNewMedicalAppointmentNotification>> sendByNotificationSMS(RequestNewMedicalAppointmentNotification parameters) async {
    try {
      if (parameters.props.isEmpty) return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.sendNotificationSMS(parameters);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
