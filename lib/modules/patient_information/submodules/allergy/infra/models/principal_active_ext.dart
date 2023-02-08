import 'dart:convert';

import 'package:medicinadireta/core/network/network_request.dart';
import 'package:medicinadireta/modules/patient_information/submodules/allergy/domain/entities/principal_active.dart';

String requestPrincipalActiveToMap(PrincipalActiveExt data) => json.encode(data.toMap());

class PrincipalActiveExt extends PrincipalActive implements NetworkRequest {
  const PrincipalActiveExt({
    super.id,
    super.concentracao,
    super.principioAtivo,
    super.unidadeMedida,
    super.status,
  });

  factory PrincipalActiveExt.fromMap(Map<String, dynamic> json) => PrincipalActiveExt(
        id: json["id"],
        concentracao: json["concentracao"],
        principioAtivo: json["principioAtivo"],
        status: json["status"],
        unidadeMedida: json["unidadeMedida"],
      );

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> request = <String, dynamic>{};

    if (id != null) request['id'] = id;
    if (concentracao != null) request['concentracao'] = concentracao;
    if (principioAtivo != null) request['principioAtivo'] = principioAtivo;
    if (unidadeMedida != null) request['unidadeMedida'] = unidadeMedida;
    if (status != null) request['status'] = status;

    return request;
  }

  PrincipalActiveExt copyWith({
    int? id,
    int? concentracao,
    String? principioAtivo,
    String? unidadeMedida,
    String? status,
  }) {
    return PrincipalActiveExt(
      id: id ?? this.id,
      concentracao: concentracao ?? this.concentracao,
      principioAtivo: principioAtivo ?? this.principioAtivo,
      unidadeMedida: unidadeMedida ?? this.unidadeMedida,
      status: status ?? this.status,
    );
  }
}
