import 'package:equatable/equatable.dart';
import '/core/models/profissional/profissional.dart';

class Allergy extends Equatable {
  final int? id;
  final int? usuarioId;
  final int? pacienteId;
  final int? semAlergia;
  final int? medicamentoId;
  final int? severidade;
  final int? tipo;
  final int? atendimentoId;
  final int? vinculoAtendimento;
  final int? versaoAtendimento;
  final int? origem;
  final int? status;
  final String? dataUtc;
  final String? dataSrv;
  final String? dataLocal;
  final String? dataEvento;
  final String? utcEvento;
  final String? descricao;
  final String? classificacaoReacao;
  final String? confirmacao;
  final String? observacao;
  final String? statusOriginal;
  final String? reacao;
  final String? fonteMedicamento;
  final String? medicamento;
  final String? principioAtivo;
  final String? formaFarmaceutica;
  final String? viaAdministracao;
  final String? dataTipo;
  final String? dataInicioOcorrido;
  final String? dataFimOcorrido;
  final String? editavel;
  final String? ativado;
  final Profissional? profissional;

  const Allergy({
    this.id,
    this.usuarioId,
    this.pacienteId,
    this.dataUtc,
    this.dataSrv,
    this.dataLocal,
    this.atendimentoId,
    this.vinculoAtendimento,
    this.versaoAtendimento,
    this.dataEvento,
    this.utcEvento,
    this.tipo,
    this.descricao,
    this.origem,
    this.classificacaoReacao,
    this.confirmacao,
    this.observacao,
    this.severidade,
    this.status,
    this.statusOriginal,
    this.reacao,
    this.semAlergia,
    this.fonteMedicamento,
    this.medicamentoId,
    this.medicamento,
    this.principioAtivo,
    this.formaFarmaceutica,
    this.viaAdministracao,
    this.dataTipo,
    this.dataInicioOcorrido,
    this.dataFimOcorrido,
    this.editavel,
    this.ativado,
    this.profissional,
  });

  Allergy copyWith({
    int? id,
    int? usuarioId,
    int? pacienteId,
    int? semAlergia,
    int? medicamentoId,
    int? severidade,
    int? tipo,
    int? atendimentoId,
    int? vinculoAtendimento,
    int? versaoAtendimento,
    int? origem,
    int? status,
    String? dataUtc,
    String? dataSrv,
    String? dataLocal,
    String? dataEvento,
    String? utcEvento,
    String? descricao,
    String? classificacaoReacao,
    String? confirmacao,
    String? observacao,
    String? statusOriginal,
    String? reacao,
    String? fonteMedicamento,
    String? medicamento,
    String? principioAtivo,
    String? formaFarmaceutica,
    String? viaAdministracao,
    String? dataTipo,
    String? dataInicioOcorrido,
    String? dataFimOcorrido,
    String? editavel,
    String? ativado,
    Profissional? profissional,
  }) =>
      Allergy(
        id: id ?? this.id,
        usuarioId: usuarioId ?? this.usuarioId,
        pacienteId: pacienteId ?? this.pacienteId,
        dataUtc: dataUtc ?? this.dataUtc,
        dataSrv: dataSrv ?? this.dataSrv,
        dataLocal: dataLocal ?? this.dataLocal,
        atendimentoId: atendimentoId ?? this.atendimentoId,
        vinculoAtendimento: vinculoAtendimento ?? this.vinculoAtendimento,
        versaoAtendimento: versaoAtendimento ?? this.versaoAtendimento,
        dataEvento: dataEvento ?? this.dataEvento,
        utcEvento: utcEvento ?? this.utcEvento,
        tipo: tipo ?? this.tipo,
        descricao: descricao ?? this.descricao,
        origem: origem ?? this.origem,
        classificacaoReacao: classificacaoReacao ?? this.classificacaoReacao,
        confirmacao: confirmacao ?? this.confirmacao,
        observacao: observacao ?? this.observacao,
        severidade: severidade ?? this.severidade,
        status: status ?? this.status,
        statusOriginal: statusOriginal ?? this.statusOriginal,
        reacao: reacao ?? this.reacao,
        semAlergia: semAlergia ?? this.semAlergia,
        fonteMedicamento: fonteMedicamento ?? this.fonteMedicamento,
        medicamentoId: medicamentoId ?? this.medicamentoId,
        medicamento: medicamento ?? this.medicamento,
        principioAtivo: principioAtivo ?? this.principioAtivo,
        formaFarmaceutica: formaFarmaceutica ?? this.formaFarmaceutica,
        viaAdministracao: viaAdministracao ?? this.viaAdministracao,
        dataTipo: dataTipo ?? this.dataTipo,
        dataInicioOcorrido: dataInicioOcorrido ?? this.dataInicioOcorrido,
        dataFimOcorrido: dataFimOcorrido ?? this.dataFimOcorrido,
        editavel: editavel ?? this.editavel,
        ativado: ativado ?? this.ativado,
        profissional: profissional ?? this.profissional,
      );

  factory Allergy.fromMap(Map<String, dynamic> json) => Allergy(
        id: json["id"],
        usuarioId: json["usuarioId"],
        pacienteId: json["pacienteId"],
        dataUtc: json["dataUTC"],
        dataSrv: json["dataSRV"],
        dataLocal: json["dataLocal"],
        atendimentoId: json["atendimentoId"],
        vinculoAtendimento: json["vinculoAtendimento"],
        versaoAtendimento: json["versaoAtendimento"],
        dataEvento: json["dataEvento"],
        utcEvento: json["utcEvento"],
        tipo: json["tipo"],
        descricao: json["descricao"],
        origem: json["origem"],
        classificacaoReacao: json["classificacaoReacao"],
        confirmacao: json["confirmacao"],
        observacao: json["observacao"],
        severidade: json["severidade"],
        status: json["status"],
        statusOriginal: json["statusOriginal"],
        reacao: json["reacao"],
        semAlergia: json["semAlergia"],
        fonteMedicamento: json["fonteMedicamento"],
        medicamentoId: json["medicamentoId"],
        medicamento: json["medicamento"],
        principioAtivo: json["principioAtivo"],
        formaFarmaceutica: json["formaFarmaceutica"],
        viaAdministracao: json["viaAdministracao"],
        dataTipo: json["dataTipo"],
        dataInicioOcorrido: json["dataInicioOcorrido"],
        dataFimOcorrido: json["dataFimOcorrido"],
        editavel: json["editavel"],
        ativado: json["ativado"],
        profissional: json["profissional"] != null ? Profissional.fromMap(json["profissional"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "usuarioId": usuarioId,
        "pacienteId": pacienteId,
        "dataUTC": dataUtc,
        "dataSRV": dataSrv,
        "dataLocal": dataLocal,
        "atendimentoId": atendimentoId,
        "vinculoAtendimento": vinculoAtendimento,
        "versaoAtendimento": versaoAtendimento,
        "dataEvento": dataEvento,
        "utcEvento": utcEvento,
        "tipo": tipo,
        "descricao": descricao,
        "origem": origem,
        "classificacaoReacao": classificacaoReacao,
        "confirmacao": confirmacao,
        "observacao": observacao,
        "severidade": severidade,
        "status": status,
        "statusOriginal": statusOriginal,
        "reacao": reacao,
        "semAlergia": semAlergia,
        "fonteMedicamento": fonteMedicamento,
        "medicamentoId": medicamentoId,
        "medicamento": medicamento,
        "principioAtivo": principioAtivo,
        "formaFarmaceutica": formaFarmaceutica,
        "viaAdministracao": viaAdministracao,
        "dataTipo": dataTipo,
        "dataInicioOcorrido": dataInicioOcorrido,
        "dataFimOcorrido": dataFimOcorrido,
        "editavel": editavel,
        "ativado": ativado,
        "profissional": profissional?.toMap(),
      };

  @override
  List<Object?> get props => [
        id,
        usuarioId,
        pacienteId,
        dataUtc,
        dataSrv,
        dataLocal,
        atendimentoId,
        vinculoAtendimento,
        versaoAtendimento,
        dataEvento,
        utcEvento,
        tipo,
        descricao,
        origem,
        classificacaoReacao,
        confirmacao,
        observacao,
        severidade,
        status,
        statusOriginal,
        reacao,
        semAlergia,
        fonteMedicamento,
        medicamentoId,
        medicamento,
        principioAtivo,
        formaFarmaceutica,
        viaAdministracao,
        dataTipo,
        dataInicioOcorrido,
        dataFimOcorrido,
        editavel,
        ativado,
        profissional,
      ];
}
