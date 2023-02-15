import 'package:medicinadireta/core/models/address/address_model.dart';
import 'package:medicinadireta/core/models/phones/patient_model_phone.dart';
import 'package:equatable/equatable.dart';

class PatientModel extends Equatable {
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
  final AddressModel? endereco;
  final List<PatientModelPhone>? telefones;


  PatientModel({
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

  @override
  List<Object?> get props => [
        odataContext!,
        id!,
        organizacaoId!,
        prontuario!,
        nome!,
        sobreNome!,
        idade!,
        cpf!,
        rg!,
        telefonePrincipal!,
        email!,
        convenioId!,
        sexo!,
        dataNascimento!,
        nomePai!,
        nomeMae!,
        responsavelLegal!,
        cpfResponsavelLegal!,
        grauParentesco!,
        observacoes!,
        nroProntuario!,
        doadorOrgao!,
        dataObito!,
        tipoSanguineo!,
        recebeEmail!,
        recebeSms!,
        ativado!,
        codigoExterno!,
        dataInclusao!,
        fotoBase64!,
        modoCadastro!,
        endereco!,
        telefones!,
      ];
}
