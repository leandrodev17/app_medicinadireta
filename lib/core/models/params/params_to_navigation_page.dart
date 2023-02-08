import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:medicinadireta/routes/app_pages.dart';
import 'package:equatable/equatable.dart';

ParamsToNavigationPage paramsToNavigationPageFromMap(String str) => ParamsToNavigationPage.fromMap(json.decode(str));

String paramsToNavigationPageToMap(ParamsToNavigationPage data) => json.encode(data.toMap());

class ParamsToNavigationPage extends Equatable {
  final int? doutorId;
  final int? agendaConfigId;
  final int? profissionalId;
  final int? organizacaoId;
  final int? pacienteId;
  final int? agendamentoId;
  final int? numeroDoProtuario;
  final int? agendaStatusId;
  final String? dataDoFiltroDePesquisa;

  ///"2021-12-04 00:00:00"
  final String? dataDoFiltroSemFormatacao;

  ///"2021-12-04 00:00:00"
  final String? horaDoAgendamento;

  ///"09:00"
  final String? nomeDoPaciente;
  final String? nomeDoMedico;
  final String? tituloDaConsulta;
  final String? observacaoDoAgendamento;
  final String? observacaoDoPaciente;
  final String? idade;
  final String? email;
  final String? telefone;
  final String? cardColor;

  /// [voltarParaPagina] [Routes.DOCTOR_ACHEDULE] é valor default.
  /// Se a navegação se iniciar da lista de paciente, o valors será [Routes.LIST_PATIENT] e ao clicar no voltar volta para lista de pacientes
  /// Essa regra será aplicada conforme a necessidade.
  final String voltarParaPagina;

  final Uint8List? photoPerfil;

  ParamsToNavigationPage({
    this.doutorId,
    this.agendaConfigId,
    this.profissionalId,
    this.organizacaoId,
    this.pacienteId,
    this.agendamentoId,
    this.dataDoFiltroDePesquisa,
    this.dataDoFiltroSemFormatacao,
    this.horaDoAgendamento,
    this.nomeDoPaciente,
    this.nomeDoMedico,
    this.tituloDaConsulta,
    this.agendaStatusId,
    this.observacaoDoAgendamento,
    this.observacaoDoPaciente,
    this.numeroDoProtuario,
    this.idade,
    this.email,
    this.telefone,
    this.voltarParaPagina = Routes.DOCTOR_ACHEDULE,
    this.photoPerfil,
    this.cardColor,
  });

  ParamsToNavigationPage copyWith({
    int? doutorId,
    int? agendaConfigId,
    int? profissionalId,
    int? organizacaoId,
    int? pacienteId,
    int? agendamentoId,
    int? numeroDoProtuario,
    int? agendaStatusId,
    String? dataDoFiltroDePesquisa,
    String? dataDoFiltroSemFormatacao,
    String? horaDoAgendamento,
    String? nomeDoPaciente,
    String? nomeDoMedico,
    String? tituloDaConsulta,
    String? observacaoDoAgendamento,
    String? observacaoDoPaciente,
    String? idade,
    String? email,
    String? telefone,
    String? voltarParaPagina,
    Uint8List? photoPerfil,
    String? cardColor,
  }) =>
      ParamsToNavigationPage(
        doutorId: doutorId ?? this.doutorId,
        agendaConfigId: agendaConfigId ?? this.agendaConfigId,
        profissionalId: profissionalId ?? this.profissionalId,
        organizacaoId: organizacaoId ?? this.organizacaoId,
        pacienteId: pacienteId ?? this.pacienteId,
        agendamentoId: agendamentoId ?? this.agendamentoId,
        dataDoFiltroDePesquisa: dataDoFiltroDePesquisa ?? this.dataDoFiltroDePesquisa,
        dataDoFiltroSemFormatacao: dataDoFiltroSemFormatacao ?? this.dataDoFiltroSemFormatacao,
        horaDoAgendamento: horaDoAgendamento ?? this.horaDoAgendamento,
        nomeDoPaciente: nomeDoPaciente ?? this.nomeDoPaciente,
        nomeDoMedico: nomeDoMedico ?? this.nomeDoMedico,
        tituloDaConsulta: tituloDaConsulta ?? this.tituloDaConsulta,
        agendaStatusId: agendaStatusId ?? this.agendaStatusId,
        observacaoDoAgendamento: observacaoDoAgendamento ?? this.observacaoDoAgendamento,
        observacaoDoPaciente: observacaoDoPaciente ?? this.observacaoDoPaciente,
        numeroDoProtuario: numeroDoProtuario ?? this.numeroDoProtuario,
        idade: idade ?? this.idade,
        email: email ?? this.email,
        telefone: telefone ?? this.telefone,
        voltarParaPagina: voltarParaPagina ?? this.voltarParaPagina,
        photoPerfil: photoPerfil ?? this.photoPerfil,
        cardColor: cardColor ?? this.cardColor,
      );

  factory ParamsToNavigationPage.fromMap(Map<String, dynamic> json) => ParamsToNavigationPage(
        doutorId: json["doutorId"],
        agendaConfigId: json["agendaConfigId"],
        profissionalId: json["profissionalId"],
        organizacaoId: json["organizacaoId"],
        pacienteId: json["pacienteId"],
        agendamentoId: json["agendamentoId"],
        dataDoFiltroDePesquisa: json["dataDoFiltroDePesquisa"],
        dataDoFiltroSemFormatacao: json["dataDoFiltroSemFormatacao"],
        horaDoAgendamento: json["horaDoAgendamento"],
        nomeDoPaciente: json["nomeDoPaciente"],
        nomeDoMedico: json["nomeDoMedico"],
        tituloDaConsulta: json["tituloDaConsulta"],
        agendaStatusId: json["agendaStatusId"],
        observacaoDoAgendamento: json["observacaoDoAgendamento"],
        observacaoDoPaciente: json["observacaoDoPaciente"],
        numeroDoProtuario: json["numeroDoProtuario"],
        idade: json["idade"],
        email: json["email"],
        telefone: json["telefone"],
        voltarParaPagina: json["voltarParaPagina"],
        photoPerfil: json["photoPerfil"],
        cardColor: json["cardColor"],
      );

  Map<String, dynamic> toMap() => {
        "doutorId": doutorId,
        "agendaConfigId": agendaConfigId,
        "profissionalId": profissionalId,
        "organizacaoId": organizacaoId,
        "pacienteId": pacienteId,
        "agendamentoId": agendamentoId,
        "dataDoFiltroDePesquisa": dataDoFiltroDePesquisa,
        "dataDoFiltroSemFormatacao": dataDoFiltroSemFormatacao,
        "horaDoAgendamento": horaDoAgendamento,
        "nomeDoPaciente": nomeDoPaciente,
        "nomeDoMedico": nomeDoMedico,
        "tituloDaConsulta": tituloDaConsulta,
        "agendaStatusId": agendaStatusId,
        "observacaoDoAgendamento": observacaoDoAgendamento,
        "observacaoDoPaciente": observacaoDoPaciente,
        "numeroDoProtuario": numeroDoProtuario,
        "idade": idade,
        "email": email,
        "telefone": telefone,
        "voltarParaPagina": voltarParaPagina,
        "photoPerfil": photoPerfil,
        "cardColor": cardColor,
      };

  @override
  List<Object?> get props => [
        this.doutorId,
        this.agendaConfigId,
        this.profissionalId,
        this.organizacaoId,
        this.pacienteId,
        this.agendamentoId,
        this.dataDoFiltroDePesquisa,
        this.dataDoFiltroSemFormatacao,
        this.horaDoAgendamento,
        this.nomeDoPaciente,
        this.nomeDoMedico,
        this.tituloDaConsulta,
        this.agendaStatusId,
        this.observacaoDoAgendamento,
        this.numeroDoProtuario,
        this.idade,
        this.email,
        this.telefone,
        this.voltarParaPagina,
        this.photoPerfil,
        this.cardColor,
      ];
}
