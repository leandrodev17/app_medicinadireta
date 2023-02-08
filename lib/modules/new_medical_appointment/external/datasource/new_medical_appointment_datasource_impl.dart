import 'dart:convert';

import 'package:medicinadireta/constants/const_endpoint.dart';
import 'package:medicinadireta/core/network/network.dart';
import 'package:medicinadireta/core/urls_modules/app_url.dart';
import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/request_medical_appointment_schedule.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/request_medical_appointment_notification.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/network/request_medical_appointment_schedule_snap.dart';
import 'package:medicinadireta/modules/new_medical_appointment/infra/datasources/new_medical_appointment_datasource.dart';
import 'package:medicinadireta/modules/new_medical_appointment/infra/models/network/response_new_medical_appointment_schedule_ext.dart';
import 'package:medicinadireta/modules/new_medical_appointment/infra/models/network/response_new_medical_appointment_notification_ext.dart';

class NewMedicalAppointmentDatasourceImpl implements NewMedicalAppointmentDatasource {
  final Network _network;
  NewMedicalAppointmentDatasourceImpl(this._network);

  @override
  Future<ResponseNewMedicalAppointmentScheduleExt> saveNewMedicalAppointmentDatasource(RequestNewMedicalAppointmentSchedule parameters, int scheduleId) async {
    try {
      final response = await _network.put(AppUrl.putSaveSchedule(scheduleId), body: parameters);
      if (response.data == null) return ResponseNewMedicalAppointmentScheduleExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);

      var statusMessage = response.statusMessage;
      var statusCode = response.statusCode;
      return ResponseNewMedicalAppointmentScheduleExt.fromMap(statusCode: statusCode, statusMessage: statusMessage, data: response.data);
    } catch (e, s) {
      AppLog.d('Não foi possível salvar novo agendamento $e', stackTrace: s, name: 'saveNewMedicalAppointmentDatasource');
      return ResponseNewMedicalAppointmentScheduleExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
    }
  }

  @override
  Future<ResponseNewMedicalAppointmentScheduleExt> saveScheduleSnapDatasource(RequestMedicalAppointmentScheduleSnap parameters) async {
    try {
      final response = await _network.post(AppUrl.postSaveSchedule(), body: parameters, isAuth: true);
      if (response.data == null) {
        return ResponseNewMedicalAppointmentScheduleExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
      }

      var statusMessage = response.statusMessage;
      var statusCode = response.statusCode;
      return ResponseNewMedicalAppointmentScheduleExt.fromMap(statusCode: statusCode, statusMessage: statusMessage, data: response.data);
    } catch (e, s) {
      AppLog.d('Não foi possível fazer o encaixe $e', stackTrace: s, name: 'saveScheduleSnapDatasource');
      return ResponseNewMedicalAppointmentScheduleExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
    }
  }

  @override
  Future<ResponseNewMedicalAppointmentNotificationExt> sendMailAppointmentDatasource(RequestNewMedicalAppointmentNotification parameters) async {
    try {
      final response = await _network.post(AppUrl.messageScheduleEmail, body: parameters, isAuth: true);
      if (response.data == null) return ResponseNewMedicalAppointmentNotificationExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
      var statusMessage = response.statusMessage;
      var statusCode = response.statusCode;
      return ResponseNewMedicalAppointmentNotificationExt.fromMap(statusCode: statusCode, statusMessage: statusMessage, data: response.data);
    } catch (e, s) {
      AppLog.d('Não foi possível enviar o e-mail $e', stackTrace: s, name: 'sendMailAppointmentDatasource');
      return ResponseNewMedicalAppointmentNotificationExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
    }
  }

  @override
  Future<ResponseNewMedicalAppointmentNotificationExt> sendSMSAppointmentDatasource(RequestNewMedicalAppointmentNotification parameters) async {
    try {
      final response = await _network.post(AppUrl.messageScheduleSms, body: parameters, isAuth: true);
      if (response.data == null) {
        return ResponseNewMedicalAppointmentNotificationExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
      }
      var statusMessage = response.statusMessage;
      var statusCode = response.statusCode;
      return ResponseNewMedicalAppointmentNotificationExt.fromMap(statusCode: statusCode, statusMessage: statusMessage, data: response.data);
    } catch (e, s) {
      AppLog.d('Não foi possível enviar o e-mail $e', stackTrace: s, name: 'sendMailAppointmentDatasource');
      return ResponseNewMedicalAppointmentNotificationExt.fromMap(statusCode: STATUS_CODE_DEFAULT, statusMessage: STATUS_MESSAGE_DEFAULT, data: null);
    }
  }
}
