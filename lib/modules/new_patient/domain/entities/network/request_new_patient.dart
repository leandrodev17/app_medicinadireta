import 'package:equatable/equatable.dart';

import '/core/network/network_request.dart';

class RequestNewPatient extends Equatable implements NetworkRequest {
  final String? nome;
  final String? email;
  final String? dataNascimento;
  final String? modoCadastro;
  final String? ddd;
  final String? celular;

  RequestNewPatient({
    this.nome,
    this.email,
    this.dataNascimento,
    this.modoCadastro,
    this.ddd,
    this.celular,
  });

  _map() {
    Map<String, dynamic> _maps = Map<String, dynamic>();

    if (this.nome != null) _maps["Nome"] = this.nome;
    if (this.email != null) _maps["email"] = this.email;
    if (this.dataNascimento != null) _maps["dataNascimento"] = this.dataNascimento;
    if (this.modoCadastro != null) _maps["ModoCadastro"] = this.modoCadastro;
    if (this.ddd != null) _maps["DDD"] = this.ddd;
    if (this.celular != null) _maps["Celular"] = this.celular;

    return _maps;
  }

  @override
  toMap() => _map();

  RequestNewPatient copyWith({
    String? nome,
    String? email,
    String? dataNascimento,
    String? modoCadastro,
    String? ddd,
    String? celular,
  }) {
    return RequestNewPatient(
      nome: nome ?? this.nome,
      email: email ?? this.email,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      modoCadastro: modoCadastro ?? this.modoCadastro,
      ddd: ddd ?? this.ddd,
      celular: celular ?? this.celular,
    );
  }

  @override
  List<Object> get props => [nome!, email!, dataNascimento!, modoCadastro!, ddd!, celular!];
}
