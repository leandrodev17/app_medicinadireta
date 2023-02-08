import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/domain/entities/medicines.dart';

class MedicamentoExt extends Medicamento {
  MedicamentoExt({
    super.id,
    super.laboratorio,
    super.descricao,
    super.apresentacao,
    super.restricaoHospitalar,
  });

  MedicamentoExt copyWith({
    int? id,
    String? laboratorio,
    String? descricao,
    String? apresentacao,
    String? restricaoHospitalar,
  }) =>
      MedicamentoExt(
        id: id ?? this.id,
        laboratorio: laboratorio ?? this.laboratorio,
        descricao: descricao ?? this.descricao,
        apresentacao: apresentacao ?? this.apresentacao,
        restricaoHospitalar: restricaoHospitalar ?? this.restricaoHospitalar,
      );

  factory MedicamentoExt.fromMap(Map<String, dynamic> json) => MedicamentoExt(
        id: json["id"],
        laboratorio: json["laboratorio"],
        descricao: json["descricao"],
        apresentacao: json["apresentacao"],
        restricaoHospitalar: json["restricaoHospitalar"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "laboratorio": laboratorio,
        "descricao": descricao,
        "apresentacao": apresentacao,
        "restricaoHospitalar": restricaoHospitalar,
      };
}
