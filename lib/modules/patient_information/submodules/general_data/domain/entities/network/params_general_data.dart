import 'package:equatable/equatable.dart';

import '/core/network/network_request.dart';

class ParamsGeneralData extends Equatable implements NetworkRequest {
  final int? id;
  final int? organizacaoId;
  final int? prontuario;
  final String? nome;
  final String? sobreNome;
  final String? cpf;
  final String? rg;
  final String? dataNascimento;
  final String? email;
  final String? sexo;
  final bool? recebeEmail;
  final bool? recebeSMS;
  final String? ativado;
  final int? convenioId;
  final String? fotoBase64;
  final String? nomePai;
  final String? nomeMae;
  final String? responsavelLegal;
  final String? cpfResponsavelLegal;
  final String? observacoes;
  final String? telCelPatient;
  final String? telResPatient;
  final String? telComPatient;

  ParamsGeneralData({
    this.id,
    this.organizacaoId,
    this.prontuario,
    this.nome,
    this.sobreNome,
    this.cpf,
    this.rg,
    this.dataNascimento,
    this.email,
    this.sexo,
    this.recebeEmail,
    this.recebeSMS,
    this.ativado,
    this.convenioId,
    this.fotoBase64,
    this.nomePai,
    this.nomeMae,
    this.responsavelLegal,
    this.cpfResponsavelLegal,
    this.observacoes,
    this.telCelPatient,
    this.telResPatient,
    this.telComPatient,
  });

  Map<String, dynamic> _map() {
    Map<String, dynamic> _data = Map<String, dynamic>();
    if (this.id != null) _data['id'] = this.id;
    if (this.organizacaoId != null) _data['organizacaoId'] = this.organizacaoId;
    if (this.prontuario != null) _data['prontuario'] = this.prontuario;
    if (this.nome != null) _data['nome'] = this.nome;
    if (this.sobreNome != null) _data['sobreNome'] = this.sobreNome;
    if (this.cpf != null) _data['cpf'] = this.cpf;
    if (this.rg != null) _data['rg'] = this.rg;
    if (this.dataNascimento != null) _data['dataNascimento'] = this.dataNascimento;
    _data['email'] = this.email;
    if (this.sexo != null) _data['sexo'] = this.sexo;
    if (this.recebeEmail != null) _data['recebeEmail'] = this.recebeEmail;
    if (this.recebeSMS != null) _data['recebeSMS'] = this.recebeSMS;
    if (this.ativado != null) _data['ativado'] = this.ativado;
    if (this.convenioId != null) _data['convenioId'] = this.convenioId;
    if (this.nomePai != null) _data['nomePai'] = this.nomePai;
    if (this.nomeMae != null) _data['nomeMae'] = this.nomeMae;
    if (this.responsavelLegal != null) _data['responsavelLegal'] = this.responsavelLegal;
    if (this.cpfResponsavelLegal != null) _data['cpfResponsavelLegal'] = this.cpfResponsavelLegal;
    if (this.observacoes != null) _data['observacoes'] = this.observacoes;
    if (this.fotoBase64 != null) _data['fotoBase64'] = this.fotoBase64;
    if (this.telCelPatient != null) _data['telCelPatient'] = this.telCelPatient;
    if (this.telResPatient != null) _data['telResPatient'] = this.telResPatient;
    if (this.telComPatient != null) _data['telComPatient'] = this.telComPatient;
    return _data;
  }

  @override
  toMap() => _map();

  @override
  List<Object> get props => [
        this.id!,
        this.organizacaoId!,
        this.prontuario!,
        this.nome!,
        this.sobreNome!,
        this.cpf!,
        this.rg!,
        this.dataNascimento!,
        this.email!,
        this.sexo!,
        this.recebeEmail!,
        this.recebeSMS!,
        this.ativado!,
        this.convenioId!,
        this.fotoBase64!,
        this.nomePai!,
        this.nomeMae!,
        this.responsavelLegal!,
        this.cpfResponsavelLegal!,
        this.observacoes!,
        this.telCelPatient!,
        this.telResPatient!,
        this.telComPatient!,
      ];

  ParamsGeneralData copyWith({
    int? id,
    int? organizacaoId,
    int? prontuario,
    String? nome,
    String? sobreNome,
    String? cpf,
    String? rg,
    String? dataNascimento,
    String? email,
    String? sexo,
    bool? recebeEmail,
    bool? recebeSMS,
    String? ativado,
    int? convenioId,
    String? fotoBase64,
    String? nomePai,
    String? nomeMae,
    String? responsavelLegal,
    String? cpfResponsavelLegal,
    String? observacoes,
    String? telCelPatient,
    String? telResPatient,
    String? telComPatient,
  }) {
    return ParamsGeneralData(
      id: id ?? this.id,
      organizacaoId: organizacaoId ?? this.organizacaoId,
      prontuario: prontuario ?? this.prontuario,
      nome: nome ?? this.nome,
      sobreNome: sobreNome ?? this.sobreNome,
      cpf: cpf ?? this.cpf,
      rg: rg ?? this.rg,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      email: email ?? this.email,
      sexo: sexo ?? this.sexo,
      recebeEmail: recebeEmail ?? this.recebeEmail,
      recebeSMS: recebeSMS ?? this.recebeSMS,
      ativado: ativado ?? this.ativado,
      convenioId: convenioId ?? this.convenioId,
      fotoBase64: fotoBase64 ?? this.fotoBase64,
      nomePai: nomePai ?? this.nomePai,
      nomeMae: nomeMae ?? this.nomeMae,
      responsavelLegal: responsavelLegal ?? this.responsavelLegal,
      cpfResponsavelLegal: cpfResponsavelLegal ?? this.cpfResponsavelLegal,
      observacoes: observacoes ?? this.observacoes,
      telCelPatient: telCelPatient ?? this.telCelPatient,
      telResPatient: telResPatient ?? this.telResPatient,
      telComPatient: telComPatient ?? this.telComPatient,
    );
  }
}
