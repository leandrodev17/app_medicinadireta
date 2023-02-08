import '/core/network/network_request.dart';
import 'package:equatable/equatable.dart';

class Headers extends Equatable implements NetworkRequest {
  final String? dataInicio;
  final String? dataFim;
  final int? profissionalId;
  final int? pacienteId;

  Headers({this.dataInicio, this.dataFim, this.profissionalId,this.pacienteId});

  _map() {
    Map<String, dynamic> _maps = Map<String, dynamic>();

    if (this.dataInicio != null) _maps["datainicio"] = this.dataInicio;
    if (this.dataFim != null) _maps["datafim"] = this.dataFim;
    if (this.profissionalId != null) _maps["profissionalid"] = this.profissionalId;
    if (this.pacienteId != null) _maps["pacienteId"] = this.pacienteId;

    return _maps;
  }

  @override
  toMap() => _map();

  @override
  List<Object> get props => [dataInicio!, dataFim!, profissionalId!,pacienteId!];
}
