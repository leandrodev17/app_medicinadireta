import 'package:equatable/equatable.dart';

import '/core/network/network_request.dart';

class RequestNewAnamnese extends Equatable implements NetworkRequest {
  final String? dataEvento;
  final String? utcEvento;
  final String? terminologiaQueixaPrincipal;
  final String? motivoAtendimento;
  final String? descricaoHda;
  final String? descricaoHpp;
  final String? descricaoHabito;
  final String? descricaoVicio;
  final String? historicoMental;
  final String? historicoFamiliar;
  final String? outros;

  RequestNewAnamnese({
    this.dataEvento,
    this.utcEvento,
    this.terminologiaQueixaPrincipal,
    this.motivoAtendimento,
    this.descricaoHda,
    this.descricaoHpp,
    this.descricaoHabito,
    this.descricaoVicio,
    this.historicoMental,
    this.historicoFamiliar,
    this.outros,
  });

  _map() {
    Map<String, dynamic> _maps = Map<String, dynamic>();

    if (this.dataEvento != null) _maps["dataEvento"] = this.dataEvento;
    // if (this.utcEvento != null) _maps["utcEvento"] = this.utcEvento;
    if (this.terminologiaQueixaPrincipal != null) _maps["terminologiaQueixaPrincipal"] = this.terminologiaQueixaPrincipal;
    if (this.motivoAtendimento != null) _maps["motivoAtendimento"] = this.motivoAtendimento;
    if (this.descricaoHda != null) _maps["descricaoHda"] = this.descricaoHda;
    if (this.descricaoHpp != null) _maps["descricaoHpp"] = this.descricaoHpp;
    if (this.descricaoHabito != null) _maps["descricaoHabito"] = this.descricaoHabito;
    if (this.descricaoVicio != null) _maps["descricaoVicio"] = this.descricaoVicio;
    if (this.historicoMental != null) _maps["historicoMental"] = this.historicoMental;
    if (this.historicoFamiliar != null) _maps["historicoFamiliar"] = this.historicoFamiliar;
    if (this.outros != null) _maps["outros"] = this.outros;

    return _maps;
  }

  @override
  toMap() => _map();

  RequestNewAnamnese copyWith({
    String? dataEvento,
    String? utcEvento,
    String? terminologiaQueixaPrincipal,
    String? motivoAtendimento,
    String? descricaoHda,
    String? descricaoHpp,
    String? descricaoHabito,
    String? descricaoVicio,
    String? historicoMental,
    String? historicoFamiliar,
    String? outros,
  }) {
    return RequestNewAnamnese(
      dataEvento: dataEvento ?? this.dataEvento,
      utcEvento: utcEvento ?? this.utcEvento,
      terminologiaQueixaPrincipal: terminologiaQueixaPrincipal ?? this.terminologiaQueixaPrincipal,
      motivoAtendimento: motivoAtendimento ?? this.motivoAtendimento,
      descricaoHda: descricaoHda ?? this.descricaoHda,
      descricaoHpp: descricaoHpp ?? this.descricaoHpp,
      descricaoHabito: descricaoHabito ?? this.descricaoHabito,
      descricaoVicio: descricaoVicio ?? this.descricaoVicio,
      historicoMental: historicoMental ?? this.historicoMental,
      historicoFamiliar: historicoFamiliar ?? this.historicoFamiliar,
      outros: outros ?? this.outros,
    );
  }

  @override
  List<Object> get props => [
        this.dataEvento!,
        this.utcEvento!,
        this.terminologiaQueixaPrincipal!,
        this.motivoAtendimento!,
        this.descricaoHda!,
        this.descricaoHpp!,
        this.descricaoHabito!,
        this.descricaoVicio!,
        this.historicoMental!,
        this.historicoFamiliar!,
        this.outros!,
      ];
}
