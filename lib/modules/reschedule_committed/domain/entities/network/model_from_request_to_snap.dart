import 'package:equatable/equatable.dart';

/// [ModelFromRequestToSnap] ESTA MODEL É SOMENTE PARA FALICITAR O CARREGAMENTO DOS DADOS DIGITADOS NO FORM DE AGENDAMENTO DE NOVA CONSULTA E ENCAIXE
/// OS VALORES VÃO PARA CONTROLLER E LÁ PREENCHE A MODEL DE REQUEST CERTA.

class ModelFromRequestToSnap extends Equatable {
  final int? id;
  final int? agendaConfigId;
  final int? pacienteId;
  final int? convenioId;
  final int? agendaSalaId;
  final int? codModeloSms;
  final int? idSms;
  final int? codModeloEmail;
  final int? idEmail;
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
  final String? assuntoModeloEmail;
  final String? assuntoModeloSms;

  ModelFromRequestToSnap({
    this.id,
    this.agendaConfigId,
    this.codModeloSms,
    this.idSms,
    this.codModeloEmail,
    this.idEmail,
    this.dataInicio,
    this.dataFim,
    this.horaInicio,
    this.horaFim,
    this.titulo,
    this.pacienteId,
    this.convenioId,
    this.agendaSalaId,
    this.observacoes,
    this.emailEnviar,
    this.email,
    this.smsEnviar,
    this.smsTelefone,
    this.online,
    this.tipoAtendimento,
    this.assuntoModeloEmail,
    this.assuntoModeloSms,
  });

  ModelFromRequestToSnap copyWith({
    int? id,
    int? agendaConfigId,
    int? pacienteId,
    int? convenioId,
    int? agendaSalaId,
    int? codModeloSms,
    int? idSms,
    int? idEmail,
    int? codModeloEmail,
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
    String? assuntoModeloSms,
    String? assuntoModeloEmail,
  }) =>
      ModelFromRequestToSnap(
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
        observacoes: observacoes ?? this.observacoes,
        emailEnviar: emailEnviar ?? this.emailEnviar,
        email: email ?? this.email,
        smsEnviar: smsEnviar ?? this.smsEnviar,
        smsTelefone: smsTelefone ?? this.smsTelefone,
        online: online ?? this.online,
        tipoAtendimento: tipoAtendimento ?? this.tipoAtendimento,
        codModeloSms: codModeloSms ?? this.codModeloSms,
        assuntoModeloSms: assuntoModeloSms ?? this.assuntoModeloSms,
        idSms: idSms ?? this.idSms,
        codModeloEmail: codModeloEmail ?? this.codModeloEmail,
        assuntoModeloEmail: assuntoModeloEmail ?? this.assuntoModeloEmail,
        idEmail: idEmail ?? this.idEmail,
      );

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
    if (this.observacoes != null) _maps["observacoes"] = this.observacoes;
    if (this.online != null) _maps["online"] = this.online;
    if (this.tipoAtendimento != null) _maps["tipoAtendimento"] = this.tipoAtendimento;

   if (this.idSms != null)_maps["idSms"] = this.idSms;
   if (this.codModeloSms != null)_maps["codModeloSms"] = this.codModeloSms;
   if (this.assuntoModeloSms != null)_maps["assuntoModeloSms"] = this.assuntoModeloSms;
   if (this.smsEnviar != null)_maps["smsEnviar"] = this.smsEnviar;
   if (this.smsTelefone != null)_maps["smsTelefone"] = this.smsTelefone;

   if (this.idEmail != null)_maps["idEmail"] = this.idEmail;
   if (this.codModeloEmail != null)_maps["codModeloEmail"] = this.codModeloEmail;
   if (this.assuntoModeloEmail != null)_maps["assuntoModeloEmail"] = this.assuntoModeloEmail;
   if (this.emailEnviar != null)_maps["emailEnviar"] = this.emailEnviar;
   if (this.email != null)_maps["email"] = this.email;
    return _maps;
  }

  @override
  List<Object?> get props => [
        this.id,
        this.agendaConfigId,
        this.codModeloSms,
        this.idSms,
        this.codModeloEmail,
        this.idEmail,
        this.dataInicio,
        this.dataFim,
        this.horaInicio,
        this.horaFim,
        this.titulo,
        this.pacienteId,
        this.convenioId,
        this.agendaSalaId,
        this.observacoes,
        this.emailEnviar,
        this.email,
        this.smsEnviar,
        this.smsTelefone,
        this.online,
        this.tipoAtendimento,
        this.assuntoModeloEmail,
        this.assuntoModeloSms,
      ];
}
