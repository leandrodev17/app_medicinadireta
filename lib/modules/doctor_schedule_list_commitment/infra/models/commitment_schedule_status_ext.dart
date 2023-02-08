import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/commitment_schedule_status.dart';

class CommitmentScheduleStatusExt extends CommitmentScheduleStatus {
  final String? descricao;
  final dynamic organizacaoId;
  final String? cor;
  final String? ativado;
  final dynamic associar;
  final dynamic dataAgendaStatus;

  CommitmentScheduleStatusExt({
    this.descricao,
    this.organizacaoId,
    this.cor,
    this.ativado,
    this.associar,
    this.dataAgendaStatus,
  });

  factory CommitmentScheduleStatusExt.fromMap(Map<String, dynamic> json) => CommitmentScheduleStatusExt(
        descricao: json["descricao"],
        organizacaoId: json["organizacaoId"],
        cor: json["cor"],
        ativado: json["ativado"],
        associar: json["associar"],
        dataAgendaStatus: json["dataAgendaStatus"],
      );

  Map<String, dynamic> toMap() => {
        "descricao": descricao,
        "organizacaoId": organizacaoId,
        "cor": cor,
        "ativado": ativado,
        "associar": associar,
        "dataAgendaStatus": dataAgendaStatus,
      };
}
