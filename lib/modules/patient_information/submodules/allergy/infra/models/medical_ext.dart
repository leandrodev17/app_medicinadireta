import 'dart:convert';

import 'package:medicinadireta/core/network/network_request.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/medical.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/infra/models/principal_active_ext.dart';

MedicalExt medicalFromMap(String str) => MedicalExt.fromMap(json.decode(str));

String medicalToMap(MedicalExt data) => json.encode(data.toMap());

class MedicalExt extends Medical implements NetworkRequest {
  const MedicalExt({
    super.id,
    super.medicamentoTipo,
    super.status,
    super.medDesc,
    super.tituloBusca,
    super.labDesc,
    super.usoIntExt,
    super.usoContinuo,
    super.qtd,
    super.unidmedida,
    super.tarja,
    super.ean1,
    super.classeTerapeutica,
    super.formaFarmaceutica,
    super.aprDesc,
    super.principioAtivo,
    super.listaControlado,
    super.antimicrobiano,
    super.principiosAtivos,
  });

  MedicalExt copyWith({
    int? id,
    int? qtd,
    String? status,
    String? medDesc,
    String? labDesc,
    String? usoIntExt,
    String? usoContinuo,
    String? unidmedida,
    String? aprDesc,
    String? principioAtivo,
    dynamic tituloBusca,
    dynamic medicamentoTipo,
    dynamic tarja,
    dynamic ean1,
    dynamic classeTerapeutica,
    dynamic formaFarmaceutica,
    String? listaControlado,
    String? antimicrobiano,
    List<PrincipalActiveExt>? principiosAtivos,
  }) =>
      MedicalExt(
        id: id ?? this.id,
        medicamentoTipo: medicamentoTipo ?? this.medicamentoTipo,
        status: status ?? this.status,
        medDesc: medDesc ?? this.medDesc,
        tituloBusca: tituloBusca ?? this.tituloBusca,
        labDesc: labDesc ?? this.labDesc,
        usoIntExt: usoIntExt ?? this.usoIntExt,
        usoContinuo: usoContinuo ?? this.usoContinuo,
        qtd: qtd ?? this.qtd,
        unidmedida: unidmedida ?? this.unidmedida,
        tarja: tarja ?? this.tarja,
        ean1: ean1 ?? this.ean1,
        classeTerapeutica: classeTerapeutica ?? this.classeTerapeutica,
        aprDesc: aprDesc ?? this.aprDesc,
        principioAtivo: principioAtivo ?? this.principioAtivo,
        listaControlado: listaControlado ?? this.listaControlado,
        formaFarmaceutica: formaFarmaceutica ?? this.formaFarmaceutica,
        antimicrobiano: antimicrobiano ?? this.antimicrobiano,
        principiosAtivos: principiosAtivos ?? this.principiosAtivos,
      );

  factory MedicalExt.fromMap(Map<String, dynamic> json) => MedicalExt(
        id: json["id"],
        medicamentoTipo: json["medicamentoTipo"],
        status: json["status"],
        medDesc: json["medDesc"],
        tituloBusca: json["tituloBusca"],
        labDesc: json["labDesc"],
        usoIntExt: json["usoIntExt"],
        usoContinuo: json["usoContinuo"],
        qtd: json["qtd"],
        unidmedida: json["unidmedida"],
        tarja: json["tarja"],
        ean1: json["ean1"],
        classeTerapeutica: json["classeTerapeutica"],
        aprDesc: json["aprDesc"],
        principioAtivo: json["principioAtivo"],
        listaControlado: json["listaControlado"],
        formaFarmaceutica: json["formaFarmaceutica"],
        antimicrobiano: json["antimicrobiano"],
        principiosAtivos: json["principiosAtivos"] != null ? List<PrincipalActiveExt>.from(json["principiosAtivos"].map((x) => PrincipalActiveExt.fromMap(x))) : null,
      );

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> request = <String, dynamic>{};
    if (id != null) request['id'] = id;
    if (medicamentoTipo != null) request['medicamentoTipo'] = medicamentoTipo;
    if (status != null) request['status'] = status;
    if (medDesc != null) request['medDesc'] = medDesc;
    if (tituloBusca != null) request['tituloBusca'] = tituloBusca;
    if (labDesc != null && labDesc.toString().isNotEmpty) request['labDesc'] = labDesc;
    if (usoIntExt != null) request['usoIntExt'] = usoIntExt;
    if (usoContinuo != null) request['usoContinuo'] = usoContinuo;
    if (qtd != null) request['qtd'] = qtd;
    if (unidmedida != null) request['unidmedida'] = unidmedida;
    if (tarja != null) request['tarja'] = tarja;
    if (ean1 != null) request['ean1'] = ean1;
    if (classeTerapeutica != null && classeTerapeutica.toString().isNotEmpty) request['classeTerapeutica'] = classeTerapeutica;
    if (aprDesc != null) request['aprDesc'] = aprDesc;
    if (principioAtivo != null) request['principioAtivo'] = principioAtivo;
    if (listaControlado != null) request['listaControlado'] = listaControlado;
    if (formaFarmaceutica != null && formaFarmaceutica.toString().isNotEmpty) request['formaFarmaceutica'] = formaFarmaceutica;
    if (antimicrobiano != null) request['antimicrobiano'] = antimicrobiano;
    if (principiosAtivos != null) request['principiosAtivos'] = principiosAtivos?.toList();
    return request;
  }
}
