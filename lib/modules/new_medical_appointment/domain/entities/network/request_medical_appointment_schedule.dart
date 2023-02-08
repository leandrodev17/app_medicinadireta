import 'package:equatable/equatable.dart';

import '/core/network/network_request.dart';

class RequestNewMedicalAppointmentSchedule extends Equatable implements NetworkRequest {
  final String? titulo;
  final int? pacienteId;
  final int? tipoAtendimento;
  final int? agendaStatusId;
  final int? modeloCorreioId;
  final int? modeloSmsId;
  final String? emailEnviar;
  final String? email;
  final String? smsEnviar;
  final String? contatoId;
  final String? smsTelefone;

  RequestNewMedicalAppointmentSchedule({
    this.titulo,
    this.pacienteId,
    this.tipoAtendimento,
    this.agendaStatusId,
    this.modeloCorreioId,
    this.modeloSmsId,
    this.emailEnviar,
    this.email,
    this.smsEnviar,
    this.contatoId,
    this.smsTelefone,
  });

  _map() {
    Map<String, dynamic> _map = Map<String, dynamic>();
    if (titulo != null) _map['titulo'] = titulo;
    if (pacienteId != null) _map['pacienteId'] = pacienteId;
    if (tipoAtendimento != null) _map['tipoAtendimento'] = tipoAtendimento;
    if (agendaStatusId != null) _map['agendaStatusId'] = agendaStatusId;
    if (this.modeloCorreioId != null) _map["modeloCorreioId"] = this.modeloCorreioId;
    if (this.modeloSmsId != null) _map["modeloSmsId"] = this.modeloSmsId;
    if (emailEnviar != null) _map['emailEnviar'] = emailEnviar;
    if (email != null) _map['email'] = email;
    if (smsEnviar != null) _map['smsEnviar'] = smsEnviar;
    if (contatoId != null) _map['contatoId'] = contatoId;
    if (smsTelefone != null) _map['smsTelefone'] = smsTelefone;
    return _map;
  }

  @override
  toMap() => _map();

  @override
  List<Object> get props => [
        this.titulo!,
        this.pacienteId!,
        this.tipoAtendimento!,
        this.agendaStatusId!,
        this.modeloCorreioId!,
        this.modeloSmsId!,
        this.emailEnviar!,
        this.email!,
        this.smsEnviar!,
        this.contatoId!,
        this.smsTelefone!,
      ];

  RequestNewMedicalAppointmentSchedule copyWith({
    String? titulo,
    int? pacienteId,
    int? tipoAtendimento,
    int? agendaStatusId,
    int? modeloCorreioId,
    int? modeloSmsId,
    String? emailEnviar,
    String? email,
    String? smsEnviar,
    String? contatoId,
    String? smsTelefone,
  }) {
    return RequestNewMedicalAppointmentSchedule(
      titulo: titulo ?? this.titulo,
      pacienteId: pacienteId ?? this.pacienteId,
      tipoAtendimento: tipoAtendimento ?? this.tipoAtendimento,
      agendaStatusId: agendaStatusId ?? this.agendaStatusId,
      modeloCorreioId: modeloCorreioId ?? this.modeloCorreioId,
      modeloSmsId: modeloSmsId ?? this.modeloSmsId,
      emailEnviar: emailEnviar ?? this.emailEnviar,
      email: email ?? this.email,
      smsEnviar: smsEnviar ?? this.smsEnviar,
      contatoId: contatoId ?? this.contatoId,
      smsTelefone: smsTelefone ?? this.smsTelefone,
    );
  }
}
