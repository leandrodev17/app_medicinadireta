import 'package:medicinadireta/core/network/network_request.dart';
import 'package:equatable/equatable.dart';

class RequestMedicalAppointmentScheduleSnap extends Equatable implements NetworkRequest {
  final int? id;
  final int? agendaConfigId;
  final int? pacienteId;
  final int? convenioId;
  final int? agendaSalaId;
  final int? contatoId;
  final int? modeloCorreioId;
  final int? modeloSmsId;
  final String? dataInicio;
  final String? dataFim;
  final String? horaInicio;
  final String? horaFim;
  final String? titulo;
  final String? observacoes;
  final String? emailEnviar;
  final String? email;
  final String? smsEnviar;
  final String? smsTelefone;
  final String? online;
  final String? tipoAtendimento;

  RequestMedicalAppointmentScheduleSnap({
    this.id,
    this.agendaConfigId,
    this.dataInicio,
    this.dataFim,
    this.horaInicio,
    this.horaFim,
    this.titulo,
    this.pacienteId,
    this.convenioId,
    this.agendaSalaId,
    this.contatoId,
    this.modeloCorreioId,
    this.modeloSmsId,
    this.observacoes,
    this.emailEnviar,
    this.email,
    this.smsEnviar,
    this.smsTelefone,
    this.online,
    this.tipoAtendimento,
  });

  RequestMedicalAppointmentScheduleSnap copyWith({
    int? id,
    int? agendaConfigId,
    int? pacienteId,
    int? convenioId,
    int? agendaSalaId,
    int? contatoId,
    int? modeloCorreioId,
    int? modeloSmsId,
    String? dataInicio,
    String? dataFim,
    String? horaInicio,
    String? horaFim,
    String? titulo,
    String? observacoes,
    String? emailEnviar,
    String? email,
    String? smsEnviar,
    String? smsTelefone,
    String? online,
    String? tipoAtendimento,
  }) =>
      RequestMedicalAppointmentScheduleSnap(
        id: id ?? this.id,
        agendaConfigId: agendaConfigId ?? this.agendaConfigId,
        dataInicio: dataInicio ?? this.dataInicio,
        dataFim: dataFim ?? this.dataFim,
        horaInicio: horaInicio ?? this.horaInicio,
        horaFim: horaFim ?? this.horaFim,
        titulo: titulo ?? this.titulo,
        pacienteId: pacienteId ?? this.pacienteId,
        convenioId: convenioId ?? this.convenioId,
        agendaSalaId: agendaSalaId ?? this.agendaSalaId,
        contatoId: contatoId ?? this.contatoId,
        modeloCorreioId: modeloCorreioId ?? this.modeloCorreioId,
        modeloSmsId: modeloSmsId ?? this.modeloSmsId,
        observacoes: observacoes ?? this.observacoes,
        emailEnviar: emailEnviar ?? this.emailEnviar,
        email: email ?? this.email,
        smsEnviar: smsEnviar ?? this.smsEnviar,
        smsTelefone: smsTelefone ?? this.smsTelefone,
        online: online ?? this.online,
        tipoAtendimento: tipoAtendimento ?? this.tipoAtendimento,
      );

  @override
  toMap() {
    Map<String, dynamic> _maps = Map<String, dynamic>();
    if (this.id != null) _maps["id"] = this.id;
    if (this.agendaConfigId != null) _maps["agendaConfigId"] = this.agendaConfigId;
    if (this.dataInicio != null) _maps["dataInicio"] = this.dataInicio;
    if (this.dataFim != null) _maps["dataFim"] = this.dataFim;
    if (this.horaInicio != null) _maps["horaInicio"] = this.horaInicio;
    if (this.horaFim != null) _maps["horaFim"] = this.horaFim;
    if (this.titulo != null) _maps["titulo"] = this.titulo;
    if (this.pacienteId != null) _maps["pacienteId"] = this.pacienteId;
    if (this.convenioId != null) _maps["convenioId"] = this.convenioId;
    if (this.agendaSalaId != null) _maps["agendaSalaId"] = this.agendaSalaId;
    if (this.contatoId != null) _maps["contatoId"] = this.contatoId;
    if (this.modeloCorreioId != null) _maps["modeloCorreioId"] = this.modeloCorreioId;
    if (this.modeloSmsId != null) _maps["modeloSmsId"] = this.modeloSmsId;
    if (this.observacoes != null) _maps["observacoes"] = this.observacoes;
    if (this.emailEnviar != null) _maps["emailEnviar"] = this.emailEnviar;
    if (this.email != null) _maps["email"] = this.email;
    if (this.smsEnviar != null) _maps["smsEnviar"] = this.smsEnviar;
    if (this.smsTelefone != null) _maps["smsTelefone"] = this.smsTelefone;
    if (this.online != null) _maps["online"] = this.online;
    if (this.tipoAtendimento != null) _maps["tipoAtendimento"] = this.tipoAtendimento;
    return _maps;
  }

  @override
  List<Object?> get props => [
        this.id,
        this.agendaConfigId,
        this.dataInicio,
        this.dataFim,
        this.horaInicio,
        this.horaFim,
        this.titulo,
        this.pacienteId,
        this.convenioId,
        this.agendaSalaId,
        this.contatoId,
        this.modeloCorreioId,
        this.modeloSmsId,
        this.observacoes,
        this.emailEnviar,
        this.email,
        this.smsEnviar,
        this.smsTelefone,
        this.online,
        this.tipoAtendimento,
      ];
}
