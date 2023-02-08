import 'dart:convert';

import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/commitment_schedule_status_ext.dart';
import 'package:medicinadireta/modules/new_medical_appointment/domain/entities/new_medical_appointment_schedule.dart';

NewMedicalAppointmentScheduleExt newMedicalAppointmentScheduleExtFromMap(String str) => NewMedicalAppointmentScheduleExt.fromMap(json.decode(str));

String newMedicalAppointmentScheduleExtToMap(NewMedicalAppointmentScheduleExt data) => json.encode(data.toMap());

class NewMedicalAppointmentScheduleExt extends NewMedicalAppointmentSchedule{
  final String? odataContext;
  final int? id;
  final int? profissionalId;
  final DateTime? dataInicio;
  final DateTime? dataFim;
  final String? horaInicio;
  final String? horaFim;
  final String? recorrencia;
  final String? periodo;
  final String? titulo;
  final String? procedimento;
  final int? pacienteId;
  final String? pacienteFlagCadastro;
  final String? observacoes;
  final int? agendaStatusId;
  final int? agendaSalaId;
  final int? agendaConfigId;
  final int? atendimentoStatusId;
  final int? filaPosicao;
  final String? emailEnviar;
  final String? email;
  final String? smsEnviar;
  final String? smsTelefone;
  final String? horaComparecimento;
  final String? horaAtendimento;
  final String? horaConcluido;
  final String? online;
  final int? usuarioCadastroId;
  final DateTime? dataCadastro;
  final String? tipoAtendimento;
  final int? usuarioAgendouId;
  final DateTime? dataUsuarioAgendou;
  final DateTime? dataInclusao;
  final String? codigoExterno;
  final CommitmentScheduleStatusExt? agendaStatus;
  NewMedicalAppointmentScheduleExt({
    this.odataContext,
    this.id,
    this.profissionalId,
    this.dataInicio,
    this.dataFim,
    this.horaInicio,
    this.horaFim,
    this.recorrencia,
    this.periodo,
    this.titulo,
    this.procedimento,
    this.pacienteId,
    this.pacienteFlagCadastro,
    this.observacoes,
    this.agendaStatusId,
    this.agendaSalaId,
    this.agendaConfigId,
    this.atendimentoStatusId,
    this.filaPosicao,
    this.emailEnviar,
    this.email,
    this.smsEnviar,
    this.smsTelefone,
    this.horaComparecimento,
    this.horaAtendimento,
    this.horaConcluido,
    this.online,
    this.usuarioCadastroId,
    this.dataCadastro,
    this.tipoAtendimento,
    this.usuarioAgendouId,
    this.dataUsuarioAgendou,
    this.dataInclusao,
    this.codigoExterno,
    this.agendaStatus,
  });

  NewMedicalAppointmentScheduleExt copyWith({
    String? odataContext,
    int? id,
    int? profissionalId,
    DateTime? dataInicio,
    DateTime? dataFim,
    String? horaInicio,
    String? horaFim,
    String? recorrencia,
    String? periodo,
    String? titulo,
    String? procedimento,
    int? pacienteId,
    String? pacienteFlagCadastro,
    String? observacoes,
    int? agendaStatusId,
    int? agendaSalaId,
    int? agendaConfigId,
    int? atendimentoStatusId,
    int? filaPosicao,
    String? emailEnviar,
    String? email,
    String? smsEnviar,
    String? smsTelefone,
    String? horaComparecimento,
    String? horaAtendimento,
    String? horaConcluido,
    String? online,
    int? usuarioCadastroId,
    DateTime? dataCadastro,
    String? tipoAtendimento,
    int? usuarioAgendouId,
    DateTime? dataUsuarioAgendou,
    DateTime? dataInclusao,
    String? codigoExterno,
    CommitmentScheduleStatusExt? agendaStatus,
  }) =>
      NewMedicalAppointmentScheduleExt(
        odataContext: odataContext ?? this.odataContext,
        id: id ?? this.id,
        profissionalId: profissionalId ?? this.profissionalId,
        dataInicio: dataInicio ?? this.dataInicio,
        dataFim: dataFim ?? this.dataFim,
        horaInicio: horaInicio ?? this.horaInicio,
        horaFim: horaFim ?? this.horaFim,
        recorrencia: recorrencia ?? this.recorrencia,
        periodo: periodo ?? this.periodo,
        titulo: titulo ?? this.titulo,
        procedimento: procedimento ?? this.procedimento,
        pacienteId: pacienteId ?? this.pacienteId,
        pacienteFlagCadastro: pacienteFlagCadastro ?? this.pacienteFlagCadastro,
        observacoes: observacoes ?? this.observacoes,
        agendaStatusId: agendaStatusId ?? this.agendaStatusId,
        agendaSalaId: agendaSalaId ?? this.agendaSalaId,
        agendaConfigId: agendaConfigId ?? this.agendaConfigId,
        atendimentoStatusId: atendimentoStatusId ?? this.atendimentoStatusId,
        filaPosicao: filaPosicao ?? this.filaPosicao,
        emailEnviar: emailEnviar ?? this.emailEnviar,
        email: email ?? this.email,
        smsEnviar: smsEnviar ?? this.smsEnviar,
        smsTelefone: smsTelefone ?? this.smsTelefone,
        horaComparecimento: horaComparecimento ?? this.horaComparecimento,
        horaAtendimento: horaAtendimento ?? this.horaAtendimento,
        horaConcluido: horaConcluido ?? this.horaConcluido,
        online: online ?? this.online,
        usuarioCadastroId: usuarioCadastroId ?? this.usuarioCadastroId,
        dataCadastro: dataCadastro ?? this.dataCadastro,
        tipoAtendimento: tipoAtendimento ?? this.tipoAtendimento,
        usuarioAgendouId: usuarioAgendouId ?? this.usuarioAgendouId,
        dataUsuarioAgendou: dataUsuarioAgendou ?? this.dataUsuarioAgendou,
        dataInclusao: dataInclusao ?? this.dataInclusao,
        codigoExterno: codigoExterno ?? this.codigoExterno,
        agendaStatus: agendaStatus ?? this.agendaStatus,
      );

  factory NewMedicalAppointmentScheduleExt.fromMap(Map<String, dynamic> json) => NewMedicalAppointmentScheduleExt(
        odataContext: json["@odata.context"],
        id: json["id"],
        profissionalId: json["profissionalId"],
        dataInicio: json["dataInicio"] != null ? DateTime.parse(json["dataInicio"]) : null,
        dataFim: json["dataFim"] != null ? DateTime.parse(json["dataFim"]) : null,
        horaInicio: json["horaInicio"],
        horaFim: json["horaFim"],
        recorrencia: json["recorrencia"],
        periodo: json["periodo"],
        titulo: json["titulo"],
        procedimento: json["procedimento"],
        pacienteId: json["pacienteId"],
        pacienteFlagCadastro: json["pacienteFlagCadastro"],
        observacoes: json["observacoes"],
        agendaStatusId: json["agendaStatusId"],
        agendaSalaId: json["agendaSalaId"],
        agendaConfigId: json["agendaConfigId"],
        atendimentoStatusId: json["atendimentoStatusId"],
        filaPosicao: json["filaPosicao"],
        emailEnviar: json["emailEnviar"],
        email: json["email"],
        smsEnviar: json["smsEnviar"],
        smsTelefone: json["smsTelefone"],
        horaComparecimento: json["horaComparecimento"],
        horaAtendimento: json["horaAtendimento"],
        horaConcluido: json["horaConcluido"],
        online: json["online"],
        usuarioCadastroId: json["usuarioCadastroId"],
        dataCadastro: json["dataCadastro"] != null ? DateTime.parse(json["dataCadastro"]) : null,
        tipoAtendimento: json["tipoAtendimento"],
        usuarioAgendouId: json["usuarioAgendouId"],
        dataUsuarioAgendou: json["dataUsuarioAgendou"] != null ? DateTime.parse(json["dataUsuarioAgendou"]) : null,
        dataInclusao: json["dataInclusao"] != null ? DateTime.parse(json["dataInclusao"]) : null,
        codigoExterno: json["codigoExterno"],
         agendaStatus: json["agendaStatus"] != null ? CommitmentScheduleStatusExt.fromMap(json["agendaStatus"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "@odata.context": odataContext,
        "id": id,
        "profissionalId": profissionalId,
        "dataInicio": dataInicio?.toIso8601String(),
        "dataFim": dataFim?.toIso8601String(),
        "horaInicio": horaInicio,
        "horaFim": horaFim,
        "recorrencia": recorrencia,
        "periodo": periodo,
        "titulo": titulo,
        "procedimento": procedimento,
        "pacienteId": pacienteId,
        "pacienteFlagCadastro": pacienteFlagCadastro,
        "observacoes": observacoes,
        "agendaStatusId": agendaStatusId,
        "agendaSalaId": agendaSalaId,
        "agendaConfigId": agendaConfigId,
        "atendimentoStatusId": atendimentoStatusId,
        "filaPosicao": filaPosicao,
        "emailEnviar": emailEnviar,
        "email": email,
        "smsEnviar": smsEnviar,
        "smsTelefone": smsTelefone,
        "horaComparecimento": horaComparecimento,
        "horaAtendimento": horaAtendimento,
        "horaConcluido": horaConcluido,
        "online": online,
        "usuarioCadastroId": usuarioCadastroId,
        "dataCadastro": dataCadastro?.toIso8601String(),
        "tipoAtendimento": tipoAtendimento,
        "usuarioAgendouId": usuarioAgendouId,
        "dataUsuarioAgendou": dataUsuarioAgendou?.toIso8601String(),
        "dataInclusao": dataInclusao?.toIso8601String(),
        "codigoExterno": codigoExterno,
         "agendaStatus": agendaStatus != null ? agendaStatus?.toMap() : null,
      };
}
