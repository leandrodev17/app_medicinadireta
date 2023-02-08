import 'package:equatable/equatable.dart';

class PatientProductsModelNewEvolution extends Equatable {
  final int? id;
  final String? titulo;
  final String? comentario;
  final String? tipo;

  PatientProductsModelNewEvolution({this.id, this.titulo, this.comentario, this.tipo});

  @override
  List<Object?> get props => [id, titulo, comentario, tipo];
}
