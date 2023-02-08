import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/commitment_schedule_address.dart';

class CommitmentScheduleAddressExt extends CommitmentScheduleAddress {
  final String? cep;
  final String? logradouro;
  final dynamic numero;
  final String? complemento;
  final String? bairro;
  final String? municipio;
  final String? uf;

  CommitmentScheduleAddressExt({
    this.cep,
    this.logradouro,
    this.numero,
    this.complemento,
    this.bairro,
    this.municipio,
    this.uf,
  });

  factory CommitmentScheduleAddressExt.fromMap(Map<String, dynamic> json) => CommitmentScheduleAddressExt(
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
