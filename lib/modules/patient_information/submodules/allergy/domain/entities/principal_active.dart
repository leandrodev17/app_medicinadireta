import 'package:equatable/equatable.dart';

class PrincipalActive extends Equatable {
  final int? id;
  final dynamic concentracao;
  final String? principioAtivo;
  final String? unidadeMedida;
  final String? status;

  const PrincipalActive({this.id,this.concentracao, this.principioAtivo, this.unidadeMedida, this.status});
  @override
  List<Object?> get props => [id,concentracao, principioAtivo, unidadeMedida, status];
}
