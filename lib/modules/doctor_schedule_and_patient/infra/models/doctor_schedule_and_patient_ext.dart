import 'package:medicinadireta/core/helpers/formats_datetime.dart';
import 'package:medicinadireta/core/models/patient/patient_model_ext.dart';
import 'package:medicinadireta/modules/doctor_schedule/infra/models/doctor_schedule_ext.dart';
import 'package:medicinadireta/modules/doctor_schedule_and_patient/domain/entities/doctor_schedule_and_patient.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/commitment_schedule_status_ext.dart';

class DoctorScheduleAndPatientExt extends DoctorScheduleAndPatient {
   String get hourFormatStart => FormatsDatetime.formatTime(horaInicio ?? '00:00');
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
  final PatientModelExt? paciente;
  final DoctorScheduleExt? agendaConfig;

  DoctorScheduleAndPatientExt({
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
    this.agendaConfig,
  });

  factory DoctorScheduleAndPatientExt.fromMap(Map<String, dynamic> json) => DoctorScheduleAndPatientExt(
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
        paciente: json["paciente"] != null ? PatientModelExt.fromMap(json["paciente"]) : null,
        agendaConfig: json["agendaConfig"] != null ? DoctorScheduleExt.fromMap(json["agendaConfig"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "profissionalId": profissionalId,
        "dataInicio": dataInicio?.toIso8601String() ?? null,
        "dataFim": dataFim?.toIso8601String() ?? null,
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
        "dataCadastro": dataCadastro?.toIso8601String() ?? null,
        "tipoAtendimento": tipoAtendimento,
        "usuarioAgendouId": usuarioAgendouId,
        "dataUsuarioAgendou": dataUsuarioAgendou?.toIso8601String() ?? null,
        "dataInclusao": dataInclusao?.toIso8601String() ?? null,
        "codigoExterno": codigoExterno,
        "agendaStatus": agendaStatus?.toMap() ?? null,
        "paciente": paciente?.toMap() ?? null,
        "agendaConfig": agendaConfig?.toMap() ?? null,
      };
}
