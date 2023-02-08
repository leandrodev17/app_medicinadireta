import 'package:medicinadireta/modules/financial/domain/entities/service_order_status.dart';

class ServiceOrderStatusExt extends ServiceOrderStatus{
  final int? id;
  final String? nome;
  ServiceOrderStatusExt({
    this.id,
    this.nome,
  });

  ServiceOrderStatusExt copyWith({
    int? id,
    String? nome,
  }) =>
      ServiceOrderStatusExt(
        id: id ?? this.id,
        nome: nome ?? this.nome,
      );

  factory ServiceOrderStatusExt.fromMap(Map<String, dynamic> json) => ServiceOrderStatusExt(
    id: json["id"],
    nome: json["nome"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nome": nome,
  };
}
