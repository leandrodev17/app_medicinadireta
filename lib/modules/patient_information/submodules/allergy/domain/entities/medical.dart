import 'package:equatable/equatable.dart';

import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/principal_active.dart';

class Medical extends Equatable {
  final int? id;
  final int? qtd;

  final String? status;
  final String? medDesc;
  final String? labDesc;
  final String? usoIntExt;
  final String? usoContinuo;
  final String? unidmedida;
  final String? aprDesc;
  final String? principioAtivo;
  final String? listaControlado;
  final String? antimicrobiano;

  final dynamic tituloBusca;
  final dynamic medicamentoTipo;
  final dynamic tarja;
  final dynamic ean1;
  final dynamic classeTerapeutica;
  final dynamic formaFarmaceutica;
  final List<PrincipalActive>? principiosAtivos;

  const Medical({
    this.id,
    this.medicamentoTipo,
    this.status,
    this.medDesc,
    this.tituloBusca,
    this.labDesc,
    this.usoIntExt,
    this.usoContinuo,
    this.qtd,
    this.unidmedida,
    this.tarja,
    this.ean1,
    this.classeTerapeutica,
    this.formaFarmaceutica,
    this.aprDesc,
    this.principioAtivo,
    this.listaControlado,
    this.antimicrobiano,
    this.principiosAtivos,
  });
  // factory Medical.fromMap(Map<String, dynamic> json) => Medical(
  //       id: json["id"],
  //       medicamentoTipo: json["medicamentoTipo"],
  //       status: json["status"],
  //       medDesc: json["medDesc"],
  //       tituloBusca: json["tituloBusca"],
  //       labDesc: json["labDesc"],
  //       usoIntExt: json["usoIntExt"],
  //       usoContinuo: json["usoContinuo"],
  //       qtd: json["qtd"],
  //       unidmedida: json["unidmedida"],
  //       tarja: json["tarja"],
  //       ean1: json["ean1"],
  //       classeTerapeutica: json["classeTerapeutica"],
  //       aprDesc: json["aprDesc"],
  //       principioAtivo: json["principioAtivo"],
  //       listaControlado: json["listaControlado"],
  //       formaFarmaceutica: json["formaFarmaceutica"],
  //       antimicrobiano: json["antimicrobiano"],
  //       principiosAtivos: json["antimicrobiano"],
  //     );

  // Map<String, dynamic> toMap() {
  //   Map<String, dynamic> request = <String, dynamic>{};
  //   request['id'] = id;
  //   request['medicamentoTipo'] = medicamentoTipo;
  //   request['status'] = status;
  //   request['medDesc'] = medDesc;
  //   request['tituloBusca'] = tituloBusca;
  //   request['labDesc'] = labDesc;
  //   request['usoIntExt'] = usoIntExt;
  //   request['usoContinuo'] = usoContinuo;
  //   request['qtd'] = qtd;
  //   request['unidmedida'] = unidmedida;
  //   request['tarja'] = tarja;
  //   request['ean1'] = ean1;
  //   request['classeTerapeutica'] = classeTerapeutica;
  //   request['aprDesc'] = aprDesc;
  //   request['principioAtivo'] = principioAtivo;
  //   request['listaControlado'] = listaControlado;
  //   request['formaFarmaceutica'] = formaFarmaceutica;
  //   request['antimicrobiano'] = antimicrobiano;
  //   return request;
  // }

  @override
  List<Object?> get props => [
        id,
        medicamentoTipo,
        status,
        medDesc,
        tituloBusca,
        labDesc,
        usoIntExt,
        usoContinuo,
        qtd,
        unidmedida,
        tarja,
        ean1,
        classeTerapeutica,
        formaFarmaceutica,
        aprDesc,
        principioAtivo,
        listaControlado,
        antimicrobiano,
        principiosAtivos,
      ];
}
