//     final requestAllergy = requestAllergyFromMap(jsonString);
import 'dart:convert';

import 'package:medicinadireta/core/network/network_request.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/network/request_allergy.dart';

String requestAllergyToMap(RequestAllergyExt data) => json.encode(data.toMap());

class RequestAllergyExt extends RequestAllergy implements NetworkRequest {
  const RequestAllergyExt({
    super.dataEvento,
    super.utcEvento,
    super.origem,
    super.tipo,
    super.status,
    super.severidade,
    super.confirmacao,
    super.classificacaoReacao,
    super.fonteMedicamento,
    super.medicamentoId,
    super.medicamento,
    super.principioAtivo,
    super.formaFarmaceutica,
    super.viaAdministracao,
    super.descricao,
    super.reacao,
    super.dataTipo,
    super.dataInicioOcorrido,
    super.dataFimOcorrido,
    super.editavel,
  });

  RequestAllergyExt copyWith({
    int? origem,
    int? tipo,
    int? status,
    int? severidade,
    int? medicamentoId,
    String? dataEvento,
    String? utcEvento,
    String? confirmacao,
    String? classificacaoReacao,
    String? fonteMedicamento,
    String? medicamento,
    String? principioAtivo,
    String? formaFarmaceutica,
    String? viaAdministracao,
    String? descricao,
    String? reacao,
    String? dataTipo,
    String? dataInicioOcorrido,
    String? dataFimOcorrido,
    String? editavel,
  }) =>
      RequestAllergyExt(
        dataEvento: dataEvento ?? this.dataEvento,
        utcEvento: utcEvento ?? this.utcEvento,
        origem: origem ?? this.origem,
        tipo: tipo ?? this.tipo,
        status: status ?? this.status,
        severidade: severidade ?? this.severidade,
        confirmacao: confirmacao ?? this.confirmacao,
        classificacaoReacao: classificacaoReacao ?? this.classificacaoReacao,
        fonteMedicamento: fonteMedicamento ?? this.fonteMedicamento,
        medicamentoId: medicamentoId ?? this.medicamentoId,
        medicamento: medicamento ?? this.medicamento,
        principioAtivo: principioAtivo ?? this.principioAtivo,
        formaFarmaceutica: formaFarmaceutica ?? this.formaFarmaceutica,
        viaAdministracao: viaAdministracao ?? this.viaAdministracao,
        descricao: descricao ?? this.descricao,
        reacao: reacao ?? this.reacao,
        dataTipo: dataTipo ?? this.dataTipo,
        dataInicioOcorrido: dataInicioOcorrido ?? this.dataInicioOcorrido,
        dataFimOcorrido: dataFimOcorrido ?? this.dataFimOcorrido,
        editavel: editavel ?? this.editavel,
      );

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> request = <String, dynamic>{};

    if (dataEvento != null) request['dataEvento'] = dataEvento;
    if (utcEvento != null) request['utcEvento'] = utcEvento;
    if (origem != null) request['origem'] = origem;
    if (tipo != null) request['tipo'] = tipo;
    if (status != null) request['status'] = status;
    if (severidade != null) request['severidade'] = severidade;
    if (confirmacao != null) request['confirmacao'] = confirmacao;
    if (classificacaoReacao != null) request['classificacaoReacao'] = classificacaoReacao;
    if (fonteMedicamento != null) request['fonteMedicamento'] = fonteMedicamento;
    if (medicamentoId != null) request['medicamentoId'] = medicamentoId;
    if (medicamento != null) request['medicamento'] = medicamento;
    // if (principioAtivo != null) request['principioAtivo'] = principioAtivo; //Não enviar na requisiçao
    if (formaFarmaceutica != null) request['formaFarmaceutica'] = formaFarmaceutica;
    if (viaAdministracao != null) request['viaAdministracao'] = viaAdministracao;
    if (descricao != null) request['descricao'] = descricao;
    if (reacao != null) request['reacao'] = reacao;
    if (dataTipo != null) request['dataTipo'] = dataTipo;
    if (dataInicioOcorrido != null) request['dataInicioOcorrido'] = dataInicioOcorrido;
    if (dataFimOcorrido != null) request['dataFimOcorrido'] = dataFimOcorrido;
    if (editavel != null) request['editavel'] = editavel;

    return request;
  }
}
