import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/request_medical_appointment_notification.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/request_medical_appointment_schedule.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/request_medical_appointment_schedule_snap.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/response_new_medical_appointment_notification.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/response_new_medical_appointment_schedule.dart';
import 'package:dartz/dartz.dart';

abstract class NewMedicalAppointmentRepository {
  Future<Either<Failures, ResponseNewMedicalAppointmentNotification>> sendNotificationMail(RequestNewMedicalAppointmentNotification parameters);
  Future<Either<Failures, ResponseNewMedicalAppointmentNotification>> sendNotificationSMS(RequestNewMedicalAppointmentNotification parameters);
  Future<Either<Failures, ResponseNewMedicalAppointmentSchedule>> saveSchedule(RequestNewMedicalAppointmentSchedule parameters, int scheduleId);
  Future<Either<Failures, ResponseNewMedicalAppointmentSchedule>> saveAppointmentSnap(RequestMedicalAppointmentScheduleSnap parameters);
}