import 'package:equatable/equatable.dart';

class Medicamento extends Equatable{
  final int? id;
  final String? laboratorio;
  final String? descricao;
  final String? apresentacao;
  final String? restricaoHospitalar;
  Medicamento({
    this.id,
    this.laboratorio,
    this.descricao,
    this.apresentacao,
    this.restricaoHospitalar,
  });

  @override
  List<Object?> get props => [
    id,
    laboratorio,
    descricao,
    apresentacao,
    restricaoHospitalar,
  ];

}