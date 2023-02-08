import 'dart:convert';
import 'package:medicinadireta/core/models/address/address_model_ext.dart';
import 'package:medicinadireta/core/models/phones/patient_model_phone_ext.dart';

import 'patient_model.dart';

PatientModelExt patientFromMap(String str) => PatientModelExt.fromMap(json.decode(str));
String patientToMap(PatientModelExt data) => json.encode(data.toMap());

class PatientModelExt extends PatientModel {
  final String? odataContext;
  final int? id;
  final int? organizacaoId;
  final int? prontuario;
  final String? nome;
  final String? sobreNome;
  final String? idade;
  final String? cpf;
  final String? rg;
  final String? telefonePrincipal;
  final String? email;
  final int? convenioId;
  final String? sexo;
  final DateTime? dataNascimento;
  final String? nomePai;
  final String? nomeMae;
  final String? responsavelLegal;
  final String? cpfResponsavelLegal;
  final String? grauParentesco;
  final String? observacoes;
  final dynamic nroProntuario;
  final String? doadorOrgao;
  final dynamic dataObito;
  final String? tipoSanguineo;
  final String? recebeEmail;
  final String? recebeSms;
  final String? ativado;
  final dynamic codigoExterno;
  final dynamic dataInclusao;
  final String? fotoBase64;
  final dynamic modoCadastro;
  final AddressModelExt? endereco;
  final List<PatientModelPhoneExt>? telefones;

  PatientModelExt({
    this.odataContext,
    this.id,
    this.organizacaoId,
    this.prontuario,
    this.nome,
    this.sobreNome,
    this.idade,
    this.cpf,
    this.rg,
    this.telefonePrincipal,
    this.email,
    this.convenioId,
    this.sexo,
    this.dataNascimento,
    this.nomePai,
    this.nomeMae,
    this.responsavelLegal,
    this.cpfResponsavelLegal,
    this.grauParentesco,
    this.observacoes,
    this.nroProntuario,
    this.doadorOrgao,
    this.dataObito,
    this.tipoSanguineo,
    this.recebeEmail,
    this.recebeSms,
    this.ativado,
    this.codigoExterno,
    this.dataInclusao,
    this.fotoBase64,
    this.modoCadastro,
    this.endereco,
    this.telefones,
  });

  PatientModelExt copyWith({
    String? odataContext,
    int? id,
    int? organizacaoId,
    int? prontuario,
    String? nome,
    String? sobreNome,
    String? idade,
    String? cpf,
    String? rg,
    String? telefonePrincipal,
    String? email,
    int? convenioId,
    String? sexo,
    DateTime? dataNascimento,
    String? nomePai,
    String? nomeMae,
    String? responsavelLegal,
    String? cpfResponsavelLegal,
    String? grauParentesco,
    String? observacoes,
    dynamic nroProntuario,
    String? doadorOrgao,
    dynamic dataObito,
    String? tipoSanguineo,
    String? recebeEmail,
    String? recebeSms,
    String? ativado,
    dynamic codigoExterno,
    dynamic dataInclusao,
    String? fotoBase64,
    dynamic modoCadastro,
    AddressModelExt? endereco,
    List<PatientModelPhoneExt>? telefones,
  }) =>
      PatientModelExt(
        odataContext: odataContext ?? this.odataContext,
        id: id ?? this.id,
        organizacaoId: organizacaoId ?? this.organizacaoId,
        prontuario: prontuario ?? this.prontuario,
        nome: nome ?? this.nome,
        sobreNome: sobreNome ?? this.sobreNome,
        idade: idade ?? this.idade,
        cpf: cpf ?? this.cpf,
        rg: rg ?? this.rg,
        telefonePrincipal: telefonePrincipal ?? this.telefonePrincipal,
        email: email ?? this.email,
        convenioId: convenioId ?? this.convenioId,
        sexo: sexo ?? this.sexo,
        dataNascimento: dataNascimento ?? this.dataNascimento,
        nomePai: nomePai ?? this.nomePai,
        nomeMae: nomeMae ?? this.nomeMae,
        responsavelLegal: responsavelLegal ?? this.responsavelLegal,
        cpfResponsavelLegal: cpfResponsavelLegal ?? this.cpfResponsavelLegal,
        grauParentesco: grauParentesco ?? this.grauParentesco,
        observacoes: observacoes ?? this.observacoes,
        nroProntuario: nroProntuario ?? this.nroProntuario,
        doadorOrgao: doadorOrgao ?? this.doadorOrgao,
        dataObito: dataObito ?? this.dataObito,
        tipoSanguineo: tipoSanguineo ?? this.tipoSanguineo,
        recebeEmail: recebeEmail ?? this.recebeEmail,
        recebeSms: recebeSms ?? this.recebeSms,
        ativado: ativado ?? this.ativado,
        codigoExterno: codigoExterno ?? this.codigoExterno,
        dataInclusao: dataInclusao ?? this.dataInclusao,
        fotoBase64: fotoBase64 ?? this.fotoBase64,
        modoCadastro: modoCadastro ?? this.modoCadastro,
        endereco: endereco ?? this.endereco,
        telefones: telefones ?? this.telefones,
      );

  factory PatientModelExt.fromMap(Map<String, dynamic> json) => PatientModelExt(
        odataContext: json["@odata.context"],
        id: json["id"],
        organizacaoId: json["organizacaoId"],
        prontuario: json["prontuario"],
        nome: json["nome"],
        sobreNome: json["sobreNome"],
        idade: json["idade"],
        cpf: json["cpf"],
        rg: json["rg"],
        telefonePrincipal: json["telefonePrincipal"],
        email: json["email"],
        convenioId: json["convenioId"],
        sexo: json["sexo"],
        dataNascimento: json["dataNascimento"] != null ? DateTime.parse(json["dataNascimento"]) : null,
        nomePai: json["nomePai"],
        nomeMae: json["nomeMae"],
        responsavelLegal: json["responsavelLegal"],
        cpfResponsavelLegal: json["cpfResponsavelLegal"],
        grauParentesco: json["grauParentesco"],
        observacoes: json["observacoes"],
        nroProntuario: json["nroProntuario"],
        doadorOrgao: json["doadorOrgao"],
        dataObito: json["dataObito"],
        tipoSanguineo: json["tipoSanguineo"],
        recebeEmail: json["recebeEmail"],
        recebeSms: json["recebeSMS"],
        ativado: json["ativado"],
        codigoExterno: json["codigoExterno"],
        dataInclusao: json["dataInclusao"],
        fotoBase64: json["fotoBase64"],
        modoCadastro: json["modoCadastro"],
        endereco: json["endereco"] != null ? AddressModelExt.fromMap(json["endereco"]) : null,
        telefones: json["telefones"] != null ? List<PatientModelPhoneExt>.from(json["telefones"].map((x) => PatientModelPhoneExt.fromMap(x))) : null,
      );

  Map<String, dynamic> toMap() => {
        "@odata.context": odataContext,
        "id": id,
        "organizacaoId": organizacaoId,
        "prontuario": prontuario,
        "nome": nome,
        "sobreNome": sobreNome,
        "idade": idade,
        "cpf": cpf,
        "rg": rg,
        "telefonePrincipal": telefonePrincipal,
        "email": email,
        "convenioId": convenioId,
        "sexo": sexo,
        "dataNascimento": dataNascimento!.toIso8601String(),
        "nomePai": nomePai,
        "nomeMae": nomeMae,
        "responsavelLegal": responsavelLegal,
        "cpfResponsavelLegal": cpfResponsavelLegal,
        "grauParentesco": grauParentesco,
        "observacoes": observacoes,
        "nroProntuario": nroProntuario,
        "doadorOrgao": doadorOrgao,
        "dataObito": dataObito,
        "tipoSanguineo": tipoSanguineo,
        "recebeEmail": recebeEmail,
        "recebeSMS": recebeSms,
        "ativado": ativado,
        "codigoExterno": codigoExterno,
        "dataInclusao": dataInclusao,
        "fotoBase64": fotoBase64,
        "modoCadastro": modoCadastro,
        "endereco": endereco != null ? endereco!.toMap() : null,
      };
}
