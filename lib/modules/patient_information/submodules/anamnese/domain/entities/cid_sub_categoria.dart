import 'package:equatable/equatable.dart';

class CidSubCategoria extends Equatable {
  final String? subCat;
  final String? descricao;

  CidSubCategoria({this.subCat, this.descricao});

  @override
  List<Object?> get props => [this.subCat, this.descricao];
}
