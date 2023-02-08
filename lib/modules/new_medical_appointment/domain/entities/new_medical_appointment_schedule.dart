import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/commitment_schedule_status_ext.dart';
import 'package:equatable/equatable.dart';

class NewMedicalAppointmentSchedule extends Equatable {
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
  
  NewMedicalAppointmentSchedule({
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

  @override
  List<Object?> get props => [
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
      ];
}
