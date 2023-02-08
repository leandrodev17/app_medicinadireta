import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/doctor_commitment.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/commitment_schedule_patient_ext.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/commitment_schedule_status_ext.dart';

class DoctorCommitmentExt extends DoctorCommitment {
  // Horário do agendamento
  String get hourFormatStart => FormatsDatetime.formatTime(horaInicio ?? '00:00');
  String get dataInicioFormat => dataInicio != null ? FormatsDatetime.formatDate(dataInicio!, FormatsDatetime.dateFormat) : '--';
  // FormatsDatetime.formatDate(_model.dataInicio!, FormatsDatetime.dateFormat);

  DateTime get dateTime {
    final time = FormatsDatetime.apiTimeFormat.parse(FormatsDatetime.formatTime(horaInicio!, withSeconds: true));
    return DateTime(dataInicio!.year, dataInicio!.month, dataInicio!.day, time.hour, time.minute, time.second);
  }

  String get horaComparecimentoFormatado => FormatsDatetime.formatTime(horaComparecimento ?? '00:00');
  String get horaAtendimentoFormatado => FormatsDatetime.formatTime(horaAtendimento ?? '00:00');
  String get horaConcluidoFormatado => FormatsDatetime.formatTime(horaConcluido ?? '00:00');

  final int? id;
  final int? profissionalId;
  final DateTime? dataInicio;
  final DateTime? dataFim;
  final String? horaInicio;
  final String? horaFim;
  final dynamic recorrencia;
  final dynamic periodo;
  final String? titulo;
  final dynamic procedimento;
  final int? pacienteId;
  final String? pacienteFlagCadastro;
  final String? observacoes;
  final int? agendaStatusId;
  final int? agendaSalaId;
  final int? agendaConfigId;
  final int? atendimentoStatusId;
  final int? filaPosicao;
  final String? emailEnviar;
  final dynamic email;
  final String? smsEnviar;
  final dynamic smsTelefone;
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
  final dynamic codigoExterno;
  final CommitmentScheduleStatusExt? agendaStatus;
  final CommitmentSchedulePatientExt? paciente;
  final Contact? contato;

  DoctorCommitmentExt({
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
    this.paciente,
    this.contato,
  });

  factory DoctorCommitmentExt.fromMap(Map<String, dynamic> json) => DoctorCommitmentExt(
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
        paciente: json["paciente"] != null ? CommitmentSchedulePatientExt.fromMap(json["paciente"]) : null,
        contato: json["contato"] != null ? Contact.fromMap(json["contato"]) : null,
      );

  Map<String, dynamic> toMap() => {
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
        "agendaStatus": agendaStatus != null ? agendaStatus!.toMap() : null,
        "paciente": paciente != null ? paciente!.toMap() : null,
        "contato": contato != null ? contato?.toMap() : null,
      };
}

// {contatoId: 10569, nome: TIAGO DELGADO}
class Contact {
  final String? nome;
  final int? contatoId;

  Contact({this.nome, this.contatoId});
  factory Contact.fromMap(Map<String, dynamic> json) => Contact(nome: json["nome"], contatoId: json["contatoId"]);
  Map<String, dynamic> toMap() => {"nome": nome, "contatoId": contatoId};
}
