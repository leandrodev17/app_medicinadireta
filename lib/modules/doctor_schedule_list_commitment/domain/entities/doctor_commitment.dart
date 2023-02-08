import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/commitment_schedule_patient.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/commitment_schedule_status.dart';
import 'package:equatable/equatable.dart';

class DoctorCommitment extends Equatable {
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
  final CommitmentScheduleStatus? agendaStatus;
  final CommitmentSchedulePatient? paciente;
  DoctorCommitment({
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
  });

  @override
  List<Object?> get props => [
        id,
        profissionalId,
        dataInicio,
        dataFim,
        horaInicio,
        horaFim,
        recorrencia,
        periodo,
        titulo,
        procedimento,
        pacienteId,
        pacienteFlagCadastro,
        observacoes,
        agendaStatusId,
        agendaSalaId,
        agendaConfigId,
        atendimentoStatusId,
        filaPosicao,
        emailEnviar,
        email,
        smsEnviar,
        smsTelefone,
        horaComparecimento,
        horaAtendimento,
        horaConcluido,
        online,
        usuarioCadastroId,
        dataCadastro,
        tipoAtendimento,
        usuarioAgendouId,
        dataUsuarioAgendou,
        dataInclusao,
        codigoExterno,
        agendaStatus,
        paciente,
      ];
}
