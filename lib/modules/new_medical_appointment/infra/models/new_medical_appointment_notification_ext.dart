import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/new_medical_appointment_notification.dart';

class NewMedicalAppointmentNotificationExt extends NewMedicalAppointmentNotification {
  final String? responseText;
  final String? data;
  final bool? sucesso;

  NewMedicalAppointmentNotificationExt({this.responseText, this.data, this.sucesso});

  NewMedicalAppointmentNotificationExt copyWith({String? responseText, String? data, bool? sucesso}) => NewMedicalAppointmentNotificationExt(
        responseText: responseText ?? this.responseText,
        data: data ?? this.data,
        sucesso: sucesso ?? this.sucesso,
      );

  factory NewMedicalAppointmentNotificationExt.fromMap(Map<String, dynamic> json) => NewMedicalAppointmentNotificationExt(
        responseText: json["responseText"],
        data: json["data"],
        sucesso: json["sucesso"],
      );

  Map<String, dynamic> toMap() => {
        "responseText": responseText,
        "data": data,
        "sucesso": sucesso,
      };
}
