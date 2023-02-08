import 'package:equatable/equatable.dart';

class CommitmentScheduleStatus extends Equatable {
  final String? descricao;
  final dynamic organizacaoId;
  final String? cor;
  final String? ativado;
  final dynamic associar;
  final dynamic dataAgendaStatus;

  CommitmentScheduleStatus({
    this.descricao,
    this.organizacaoId,
    this.cor,
    this.ativado,
    this.associar,
    this.dataAgendaStatus,
  });

  @override
  List<Object?> get props => [
        descricao,
        organizacaoId,
        cor,
        ativado,
        associar,
        dataAgendaStatus,
      ];
}
