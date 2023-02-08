import 'package:equatable/equatable.dart';

class ServiceOrderStatus extends Equatable{
  final int? id;
  final String? nome;
  ServiceOrderStatus({
    this.id,
    this.nome,
  });

  @override
  List<Object?> get props => [
    id,
    nome
  ];
}
