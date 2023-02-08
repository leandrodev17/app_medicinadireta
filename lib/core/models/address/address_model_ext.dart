
import 'address_model.dart';

class AddressModelExt extends AddressModel {
  final String? cep;
  final String? logradouro;
  final String? numero;
  final String? complemento;
  final String? bairro;
  final String? municipio;
  final String? uf;

  AddressModelExt({
    this.cep,
    this.logradouro,
    this.numero,
    this.complemento,
    this.bairro,
    this.municipio,
    this.uf,
  });

  AddressModelExt copyWith({
    String? cep,
    String? logradouro,
    String? numero,
    String? complemento,
    String? bairro,
    String? municipio,
    String? uf,
  }) =>
      AddressModelExt(
        cep: cep ?? this.cep,
        logradouro: logradouro ?? this.logradouro,
        numero: numero ?? this.numero,
        complemento: complemento ?? this.complemento,
        bairro: bairro ?? this.bairro,
        municipio: municipio ?? this.municipio,
        uf: uf ?? this.uf,
      );

  factory AddressModelExt.fromMap(Map<String, dynamic> json) => AddressModelExt(
        cep: json["cep"],
        logradouro: json["logradouro"],
        numero: json["numero"],
        complemento: json["complemento"],
        bairro: json["bairro"],
        municipio: json["municipio"],
        uf: json["uf"],
      );

  Map<String, dynamic> toMap() => {
        "cep": cep,
        "logradouro": logradouro,
        "numero": numero,
        "complemento": complemento,
        "bairro": bairro,
        "municipio": municipio,
        "uf": uf,
      };
}
