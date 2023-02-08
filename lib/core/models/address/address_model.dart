import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final String? cep;
  final String? logradouro;
  final String? numero;
  final String? complemento;
  final String? bairro;
  final String? municipio;
  final String? uf;
  
  AddressModel({
    this.cep,
    this.logradouro,
    this.numero,
    this.complemento,
    this.bairro,
    this.municipio,
    this.uf,
  });

  @override
  List<Object?> get props => [
        cep,
        logradouro,
        numero,
        complemento,
        bairro,
        municipio,
        uf,
      ];
}
