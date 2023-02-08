import 'package:equatable/equatable.dart';

import 'conselho.dart';

class Profissional extends Equatable {
  final String? nome;
  final List<Conselho>? conselho;

  const Profissional({this.nome, this.conselho});

  factory Profissional.fromMap(Map<String, dynamic> json) => Profissional(
        nome: json["nome"],
        conselho: json["conselho"] != null ? List<Conselho>.from(json["conselho"].map((x) => Conselho.fromMap(x))) : null,
      );

  Map<String, dynamic> toMap() => {
        "nome": nome,
        "conselho": conselho?.map((v) => v.toMap()).toList(),
      };

  Profissional copyWith({
    String? nome,
    List<Conselho>? conselho,
  }) =>
      Profissional(
        nome: nome ?? this.nome,
        conselho: conselho ?? this.conselho,
      );

  @override
  List<Object?> get props => [nome, conselho];
}
