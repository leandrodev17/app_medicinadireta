import '/core/network/network_request.dart';
import 'package:equatable/equatable.dart';

class ParamsDoctorCommitmentHeaders extends Equatable implements NetworkRequest {
  final String? dataInicio;
  final String? dataFim;
  final int? profissionalId;

  ParamsDoctorCommitmentHeaders({required this.dataInicio, required this.dataFim, this.profissionalId});

  _map() {
    Map<String, dynamic> _maps = Map<String, dynamic>();

    if (this.dataInicio != null) _maps["datainicio"] = this.dataInicio;
    if (this.dataFim != null) _maps["datafim"] = this.dataFim;
    // if (this.profissionalId != null) _maps["profissionalid"] = this.profissionalId;

    return _maps;
  }

  @override
  toMap() => _map();

  @override
  List<Object> get props => [this.dataInicio!, this.dataFim!, this.profissionalId!];
}
