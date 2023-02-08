import 'package:medicinadireta/modules/patient_information/submodules/attachments/domain/entities/attachments.dart';

class AttachmentsExt extends Attachments {
  final int? id; // Mesmo para o retorno no arquivoBase64 Busca pelo arquivo
  final String? nomeArquivo;
  final String? arquivoBase64; // vem do retorno do arquivoBase64 Busca pelo arquivo
  final String? legenda; // descriçao da foto

  final int? pacienteId;
  final int? atendimentoId;
  final int? versaoAtendimento;
  final int? vinculoAtendimento;
  final String? palavrasChave;
  final int? tamanhoArquivo;
  final String? tipoArquivo;
  final String? dataFoto;
  final String? dataInclusao;
  final String? dataAlteracao;
  final String? dataLocal;
  final String? dataUltAcesso;
  final String? dataUtc;
  final String? utcEvento;
  final String? editavel;
  final String? ativado;
  final String? statusAssinatura;
  final String? azure;
  final String? logUsuario;

  AttachmentsExt({
    this.id,
    this.pacienteId,
    this.legenda,
    this.palavrasChave,
    this.nomeArquivo,
    this.tamanhoArquivo,
    this.tipoArquivo,
    this.dataFoto,
    this.dataInclusao,
    this.dataAlteracao,
    this.dataLocal,
    this.dataUltAcesso,
    this.dataUtc,
    this.utcEvento,
    this.editavel,
    this.ativado,
    this.statusAssinatura,
    this.azure,
    this.logUsuario,
    this.atendimentoId,
    this.versaoAtendimento,
    this.vinculoAtendimento,
    this.arquivoBase64,
  });

  AttachmentsExt copyWith({
    int? id,
    int? atendimentoId,
    int? versaoAtendimento,
    int? vinculoAtendimento,
    int? pacienteId,
    String? legenda,
    String? palavrasChave,
    String? nomeArquivo,
    int? tamanhoArquivo,
    String? tipoArquivo,
    String? dataFoto,
    String? dataInclusao,
    String? dataAlteracao,
    String? dataLocal,
    String? dataUltAcesso,
    String? dataUtc,
    String? utcEvento,
    String? editavel,
    String? ativado,
    String? statusAssinatura,
    String? azure,
    String? logUsuario,
    String? arquivoBase64,
  }) =>
      AttachmentsExt(
        id: id ?? this.id,
        pacienteId: pacienteId ?? this.pacienteId,
        legenda: legenda ?? this.legenda,
        palavrasChave: palavrasChave ?? this.palavrasChave,
        nomeArquivo: nomeArquivo ?? this.nomeArquivo,
        tamanhoArquivo: tamanhoArquivo ?? this.tamanhoArquivo,
        tipoArquivo: tipoArquivo ?? this.tipoArquivo,
        dataFoto: dataFoto ?? this.dataFoto,
        dataInclusao: dataInclusao ?? this.dataInclusao,
        dataAlteracao: dataAlteracao ?? this.dataAlteracao,
        dataLocal: dataLocal ?? this.dataLocal,
        dataUltAcesso: dataUltAcesso ?? this.dataUltAcesso,
        dataUtc: dataUtc ?? this.dataUtc,
        utcEvento: utcEvento ?? this.utcEvento,
        editavel: editavel ?? this.editavel,
        ativado: ativado ?? this.ativado,
        statusAssinatura: statusAssinatura ?? this.statusAssinatura,
        azure: azure ?? this.azure,
        logUsuario: logUsuario ?? this.logUsuario,
        atendimentoId: atendimentoId ?? this.atendimentoId,
        versaoAtendimento: versaoAtendimento ?? this.versaoAtendimento,
        vinculoAtendimento: vinculoAtendimento ?? this.vinculoAtendimento,
        arquivoBase64: arquivoBase64 ?? this.arquivoBase64,
      );

  factory AttachmentsExt.fromMap(Map<String, dynamic> json) => AttachmentsExt(
        id: json["id"],
        pacienteId: json["pacienteId"],
        legenda: json["legenda"],
        palavrasChave: json["palavrasChave"],
        nomeArquivo: json["nomeArquivo"],
        tamanhoArquivo: json["tamanhoArquivo"],
        tipoArquivo: json["tipoArquivo"],
        dataFoto: json["dataFoto"],
        dataInclusao: json["dataInclusao"],
        dataAlteracao: json["dataAlteracao"],
        dataLocal: json["dataLocal"],
        dataUltAcesso: json["dataUltAcesso"],
        dataUtc: json["dataUtc"],
        utcEvento: json["utcEvento"],
        editavel: json["editavel"],
        ativado: json["ativado"],
        statusAssinatura: json["statusAssinatura"],
        azure: json["azure"],
        logUsuario: json["logUsuario"],
        atendimentoId: json["atendimentoId"],
        versaoAtendimento: json["versaoAtendimento"],
        vinculoAtendimento: json["vinculoAtendimento"],
        arquivoBase64: json["arquivoBase64"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "pacienteId": pacienteId,
        "legenda": legenda,
        "palavrasChave": palavrasChave,
        "nomeArquivo": nomeArquivo,
        "tamanhoArquivo": tamanhoArquivo,
        "tipoArquivo": tipoArquivo,
        "dataFoto": dataFoto,
        "dataInclusao": dataInclusao,
        "dataAlteracao": dataAlteracao,
        "dataLocal": dataLocal,
        "dataUltAcesso": dataUltAcesso,
        "dataUtc": dataUtc,
        "utcEvento": utcEvento,
        "editavel": editavel,
        "ativado": ativado,
        "statusAssinatura": statusAssinatura,
        "azure": azure,
        "logUsuario": logUsuario,
        "atendimentoId": atendimentoId,
        "versaoAtendimento": versaoAtendimento,
        "vinculoAtendimento": vinculoAtendimento,
        "arquivoBase64": arquivoBase64,
      };
}
