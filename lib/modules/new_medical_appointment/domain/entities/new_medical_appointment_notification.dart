import 'package:equatable/equatable.dart';

class NewMedicalAppointmentNotification extends Equatable {

  final String? responseText;
  final String? data;
  final bool? sucesso;

  NewMedicalAppointmentNotification({this.responseText, this.data, this.sucesso});

  @override
  List<Object?> get props => [responseText, data, sucesso];
}
