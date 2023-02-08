import 'package:medicinadireta/modules/doctor_schedule_list_commitment/domain/entities/commitment_schedule_patient.dart';
import 'package:medicinadireta/modules/doctor_schedule_list_commitment/infra/models/commitment_schedule_address_ext.dart';

class CommitmentSchedulePatientExt extends CommitmentSchedulePatient {
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
  final String? dataNascimento;
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
  final CommitmentScheduleAddressExt? endereco;

  CommitmentSchedulePatientExt({
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
  });
  factory CommitmentSchedulePatientExt.fromMap(Map<String, dynamic> json) => CommitmentSchedulePatientExt(
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
        dataNascimento: json["dataNascimento"],
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
        endereco: json["endereco"] != null ? CommitmentScheduleAddressExt.fromMap(json["endereco"]):null,
      );

  Map<String, dynamic> toMap() => {
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
        "dataNascimento": dataNascimento,
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
        "endereco": endereco != null ? endereco?.toMap() : null,
      };
}
