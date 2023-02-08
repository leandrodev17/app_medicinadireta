import 'package:equatable/equatable.dart';

import 'package:medicinadireta/core/network/network_request.dart';

class RequestRescheduleDefault extends Equatable implements NetworkRequest {
  final RequestRescheduleSnap? remarcarEncaixe;
  final RequestReschedule? remarcar;

  RequestRescheduleDefault({this.remarcarEncaixe, this.remarcar});

  _map() {
    Map<String, dynamic> _maps = Map<String, dynamic>();
    if (this.remarcarEncaixe != null) _maps["remarcar_encaixe"] = this.remarcarEncaixe?.toMap();
    if (this.remarcar != null) _maps["remarcar"] = this.remarcar?.toMap();
    return _maps;
  }

  @override
  toMap() => _map();

  @override
  List<Object?> get props => [this.remarcarEncaixe];
}

class RequestRescheduleSnap extends Equatable {
  final int? agendaConfigId;
  final String? data;
  final String? horaEncaixe;
  final String? tipoAtendimento;
  final String? observacoes;
  final String? titulo;

  RequestRescheduleSnap({this.titulo,this.agendaConfigId, this.data, this.horaEncaixe, this.observacoes, this.tipoAtendimento});

  toMap() {
    Map<String, dynamic> _maps = Map<String, dynamic>();

    if (this.agendaConfigId != null) _maps["agendaConfigId"] = this.agendaConfigId;
    if (this.data != null) _maps["data"] = this.data;
    if (this.horaEncaixe != null) _maps["horaEncaixe"] = this.horaEncaixe;
    if (this.tipoAtendimento != null) _maps["tipoAtendimento"] = this.tipoAtendimento;
    if (this.observacoes != null) _maps["observacoes"] = this.observacoes;
    if (this.titulo != null) _maps["titulo"] = this.titulo;

    return _maps;
  }

  @override
  List<Object?> get props => [this.titulo,this.agendaConfigId, this.data, this.horaEncaixe, this.tipoAtendimento, this.observacoes];

  RequestRescheduleSnap copyWith({int? agendaConfigId, String? data, String? horaEncaixe, String? tipoAtendimento, String? observacoes, String? titulo}) {
    return RequestRescheduleSnap(
      agendaConfigId: agendaConfigId ?? this.agendaConfigId,
      data: data ?? this.data,
      horaEncaixe: horaEncaixe ?? this.horaEncaixe,
      tipoAtendimento: tipoAtendimento ?? this.tipoAtendimento,
      observacoes: observacoes ?? this.observacoes,
      titulo: titulo ?? this.titulo,
    );
  }
}


class RequestReschedule extends Equatable {
  final int? novoAgendamentoId;

  RequestReschedule({this.novoAgendamentoId});

  toMap() {
    Map<String, dynamic> _maps = Map<String, dynamic>();
    if (this.novoAgendamentoId != null) _maps["novoAgendamentoId"] = this.novoAgendamentoId;
    return _maps;
  }

  @override
  List<Object?> get props => [this.novoAgendamentoId];

  RequestReschedule copyWith({int? novoAgendamentoId}) => RequestReschedule(novoAgendamentoId: novoAgendamentoId ?? this.novoAgendamentoId);
}
