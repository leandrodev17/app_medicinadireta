import 'package:equatable/equatable.dart';

class Conselho extends Equatable {
  final int? id;
  final String? conselhoTipo;
  final String? numeroConselho;

  const Conselho({this.id, this.conselhoTipo, this.numeroConselho});

  factory Conselho.fromMap(Map<String, dynamic> json) => Conselho(
        id: json["id"],
        conselhoTipo: json["conselhoTipo"],
        numeroConselho: json["numeroConselho"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "conselhoTipo": conselhoTipo,
        "numeroConselho": numeroConselho,
      };

  @override
  List<Object?> get props => [id, conselhoTipo, numeroConselho];
}
