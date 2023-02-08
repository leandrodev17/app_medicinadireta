import '/core/network/network_request.dart';
import 'package:equatable/equatable.dart';

class RequestNewPhone extends Equatable implements NetworkRequest {
  final String? ddd;
  final String? numero;
  final String? tipo;

  RequestNewPhone({this.ddd, this.numero, this.tipo});

  _map() {
    Map<String, dynamic> _maps = Map<String, dynamic>();

    if (this.numero != null) _maps["numero"] = this.numero;
    if (this.tipo != null) _maps["tipo"] = this.tipo;
    if (this.ddd != null) _maps["ddd"] = this.ddd;

    return _maps;
  }

  @override
  toMap() => _map();

  @override
  List<Object> get props => [ddd!, tipo!, numero!];
}
