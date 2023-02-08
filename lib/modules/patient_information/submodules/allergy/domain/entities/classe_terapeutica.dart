import 'package:equatable/equatable.dart';

class ClasseTerapeutica extends Equatable {
  final String? codigo;
  final String? descricao;
  final String? composto;
  final String? ihh;
  final int? nivel;
  final int? id;

  const ClasseTerapeutica({this.codigo, this.descricao, this.composto, this.ihh, this.nivel, this.id});

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'descricao': descricao,
      'composto': composto,
      'ihh': ihh,
      'nivel': nivel,
      'id': id,
    };
  }

  @override
  List<Object?> get props => [codigo, descricao, composto, ihh, nivel, id];
}
