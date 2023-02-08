import 'package:medicinadireta/modules/doctor_schedule/domain/entities/doctor_schedule.dart';

class DoctorScheduleExt extends DoctorSchedule {
  final int? id;
  final String? descricao;
  final dynamic observacao;
  final DateTime? dataAgenda;
  final int? clinicaId;
  final int? filialId;
  final int? profissionalId;
  final int? agendaSalaId;
  final dynamic tipoAgenda;
  final String? cbo;
  final String? cor;
  final String? seg;
  final String? ter;
  final String? qua;
  final String? qui;
  final String? sex;
  final String? sab;
  final String? dom;
  final String? segIni1;
  final String? segFim1;
  final String? segIni2;
  final String? segFim2;
  final String? terIni1;
  final String? terFim1;
  final String? terIni2;
  final String? terFim2;
  final String? quaIni1;
  final String? quaFim1;
  final String? quaIni2;
  final String? quaFim2;
  final String? quiIni1;
  final String? quiFim1;
  final String? quiIni2;
  final String? quiFim2;
  final String? sexIni1;
  final String? sexFim1;
  final String? sexIni2;
  final String? sexFim2;
  final String? sabIni1;
  final String? sabFim1;
  final String? sabIni2;
  final String? sabFim2;
  final String? domIni1;
  final String? domFim1;
  final String? domIni2;
  final String? domFim2;
  final String? tempoAtendimento;
  final String? intervaloAtendimento;
  final String? tempoAtendimentoDomingo;
  final String? tempoAtendimentoSegunda;
  final String? tempoAtendimentoTerca;
  final String? tempoAtendimentoQuarta;
  final String? tempoAtendimentoQuinta;
  final String? tempoAtendimentoSexta;
  final String? tempoAtendimentoSabado;
  final int? clone;
  final String? novoConfigHorario;
  final String? ativado;
  final String? online;
  final String? quantidadeDias;
  final int? usuarioId;

  DoctorScheduleExt({
    this.id,
    this.descricao,
    this.observacao,
    this.dataAgenda,
    this.clinicaId,
    this.filialId,
    this.profissionalId,
    this.agendaSalaId,
    this.tipoAgenda,
    this.cbo,
    this.cor,
    this.seg,
    this.ter,
    this.qua,
    this.qui,
    this.sex,
    this.sab,
    this.dom,
    this.segIni1,
    this.segFim1,
    this.segIni2,
    this.segFim2,
    this.terIni1,
    this.terFim1,
    this.terIni2,
    this.terFim2,
    this.quaIni1,
    this.quaFim1,
    this.quaIni2,
    this.quaFim2,
    this.quiIni1,
    this.quiFim1,
    this.quiIni2,
    this.quiFim2,
    this.sexIni1,
    this.sexFim1,
    this.sexIni2,
    this.sexFim2,
    this.sabIni1,
    this.sabFim1,
    this.sabIni2,
    this.sabFim2,
    this.domIni1,
    this.domFim1,
    this.domIni2,
    this.domFim2,
    this.tempoAtendimento,
    this.intervaloAtendimento,
    this.tempoAtendimentoDomingo,
    this.tempoAtendimentoSegunda,
    this.tempoAtendimentoTerca,
    this.tempoAtendimentoQuarta,
    this.tempoAtendimentoQuinta,
    this.tempoAtendimentoSexta,
    this.tempoAtendimentoSabado,
    this.clone,
    this.novoConfigHorario,
    this.ativado,
    this.online,
    this.quantidadeDias,
    this.usuarioId,
  });

  factory DoctorScheduleExt.fromMap(Map<String, dynamic> json) => DoctorScheduleExt(
        id: json["id"],
        descricao: json["descricao"],
        observacao: json["observacao"],
        dataAgenda: json["dataAgenda"] != null ? DateTime.parse(json["dataAgenda"]) : null,
        clinicaId: json["clinicaId"],
        filialId: json["filialId"],
        profissionalId: json["profissionalId"],
        agendaSalaId: json["agendaSalaId"],
        tipoAgenda: json["tipoAgenda"],
        cbo: json["cbo"],
        cor: json["cor"],
        seg: json["seg"],
        ter: json["ter"],
        qua: json["qua"],
        qui: json["qui"],
        sex: json["sex"],
        sab: json["sab"],
        dom: json["dom"],
        segIni1: json["segIni1"],
        segFim1: json["segFim1"],
        segIni2: json["segIni2"],
        segFim2: json["segFim2"],
        terIni1: json["terIni1"],
        terFim1: json["terFim1"],
        terIni2: json["terIni2"],
        terFim2: json["terFim2"],
        quaIni1: json["quaIni1"],
        quaFim1: json["quaFim1"],
        quaIni2: json["quaIni2"],
        quaFim2: json["quaFim2"],
        quiIni1: json["quiIni1"],
        quiFim1: json["quiFim1"],
        quiIni2: json["quiIni2"],
        quiFim2: json["quiFim2"],
        sexIni1: json["sexIni1"],
        sexFim1: json["sexFim1"],
        sexIni2: json["sexIni2"],
        sexFim2: json["sexFim2"],
        sabIni1: json["sabIni1"],
        sabFim1: json["sabFim1"],
        sabIni2: json["sabIni2"],
        sabFim2: json["sabFim2"],
        domIni1: json["domIni1"],
        domFim1: json["domFim1"],
        domIni2: json["domIni2"],
        domFim2: json["domFim2"],
        tempoAtendimento: json["tempoAtendimento"],
        intervaloAtendimento: json["intervaloAtendimento"],
        tempoAtendimentoDomingo: json["tempoAtendimentoDomingo"],
        tempoAtendimentoSegunda: json["tempoAtendimentoSegunda"],
        tempoAtendimentoTerca: json["tempoAtendimentoTerca"],
        tempoAtendimentoQuarta: json["tempoAtendimentoQuarta"],
        tempoAtendimentoQuinta: json["tempoAtendimentoQuinta"],
        tempoAtendimentoSexta: json["tempoAtendimentoSexta"],
        tempoAtendimentoSabado: json["tempoAtendimentoSabado"],
        clone: json["clone"],
        novoConfigHorario: json["novoConfigHorario"],
        ativado: json["ativado"],
        online: json["online"],
        quantidadeDias: json["quantidadeDias"],
        usuarioId: json["usuarioId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "descricao": descricao,
        "observacao": observacao,
        "dataAgenda": dataAgenda?.toIso8601String(),
        "clinicaId": clinicaId,
        "filialId": filialId,
        "profissionalId": profissionalId,
        "agendaSalaId": agendaSalaId,
        "tipoAgenda": tipoAgenda,
        "cbo": cbo,
        "cor": cor,
        "seg": seg,
        "ter": ter,
        "qua": qua,
        "qui": qui,
        "sex": sex,
        "sab": sab,
        "dom": dom,
        "segIni1": segIni1,
        "segFim1": segFim1,
        "segIni2": segIni2,
        "segFim2": segFim2,
        "terIni1": terIni1,
        "terFim1": terFim1,
        "terIni2": terIni2,
        "terFim2": terFim2,
        "quaIni1": quaIni1,
        "quaFim1": quaFim1,
        "quaIni2": quaIni2,
        "quaFim2": quaFim2,
        "quiIni1": quiIni1,
        "quiFim1": quiFim1,
        "quiIni2": quiIni2,
        "quiFim2": quiFim2,
        "sexIni1": sexIni1,
        "sexFim1": sexFim1,
        "sexIni2": sexIni2,
        "sexFim2": sexFim2,
        "sabIni1": sabIni1,
        "sabFim1": sabFim1,
        "sabIni2": sabIni2,
        "sabFim2": sabFim2,
        "domIni1": domIni1,
        "domFim1": domFim1,
        "domIni2": domIni2,
        "domFim2": domFim2,
        "tempoAtendimento": tempoAtendimento,
        "intervaloAtendimento": intervaloAtendimento,
        "tempoAtendimentoDomingo": tempoAtendimentoDomingo,
        "tempoAtendimentoSegunda": tempoAtendimentoSegunda,
        "tempoAtendimentoTerca": tempoAtendimentoTerca,
        "tempoAtendimentoQuarta": tempoAtendimentoQuarta,
        "tempoAtendimentoQuinta": tempoAtendimentoQuinta,
        "tempoAtendimentoSexta": tempoAtendimentoSexta,
        "tempoAtendimentoSabado": tempoAtendimentoSabado,
        "clone": clone,
        "novoConfigHorario": novoConfigHorario,
        "ativado": ativado,
        "online": online,
        "quantidadeDias": quantidadeDias,
        "usuarioId": usuarioId,
      };
}
