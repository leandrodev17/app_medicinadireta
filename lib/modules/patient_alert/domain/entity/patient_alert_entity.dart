import 'package:equatable/equatable.dart';

class PatientAlertEntity extends Equatable {
  final int? id;
  final int? usuarioId;
  final int? conselhoNumero;
  final int? registroId;
  final int? pacienteId;
  final String? avisoTipo;
  final String? descricao;
  final String? alergia;
  final String? usuarioNome;
  final String? conselhoUf;
  final String? dataEvento;
  final String? conselho;
  final String? soap;
  final String? ativado;
  final String? editavel;
  final String? principioAtivo;
  final String? cor;

  const PatientAlertEntity({
    this.id,
    this.usuarioId,
    this.conselhoNumero,
    this.principioAtivo,
    this.registroId,
    this.pacienteId,
    this.avisoTipo,
    this.descricao,
    this.alergia,
    this.usuarioNome,
    this.conselhoUf,
    this.dataEvento,
    this.conselho,
    this.soap,
    this.ativado,
    this.editavel,
    this.cor,
  });

  @override
  List<Object?> get props => [
        descricao,
        alergia,
        usuarioId,
        usuarioNome,
        conselho,
        conselhoUf,
        principioAtivo,
        conselhoNumero,
        dataEvento,
        registroId,
        avisoTipo,
        soap,
        pacienteId,
        ativado,
        editavel,
        id,
        cor,
      ];
}
