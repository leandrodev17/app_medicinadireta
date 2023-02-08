import 'package:equatable/equatable.dart';

class PatientModelPhone extends Equatable {
  final int? pacienteId;
  final DateTime? data;
  final String? tipo;
  final String? codTipo;
  final String? operadora;
  final String? ddi;
  final String? ddd;
  final String? numero;
  final String? ramal;
  final String? receberSms;
  final String? observacao;
  final String? ativado;
  
  PatientModelPhone({
    this.pacienteId,
    this.data,
    this.tipo,
    this.codTipo,
    this.operadora,
    this.ddi,
    this.ddd,
    this.numero,
    this.ramal,
    this.receberSms,
    this.observacao,
    this.ativado,
  });

  @override
  List<Object?> get props => [
        pacienteId,
        data,
        tipo,
        codTipo,
        operadora,
        ddi,
        ddd,
        numero,
        ramal,
        receberSms,
        observacao,
        ativado,
      ];
}
