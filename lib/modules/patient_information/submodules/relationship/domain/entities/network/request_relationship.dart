import '/core/network/network_request.dart';
import 'package:equatable/equatable.dart';

class RequestRelationship extends Equatable implements NetworkRequest {
  final String relacionamento;
  RequestRelationship({
    required this.relacionamento,
  });

  _map() {
    Map<String, dynamic> _p = {
      'relacionamento': this.relacionamento,
    };
    return _p;
  }

  @override
  toMap() => _map();

  @override
  List<Object> get props => [relacionamento];
}
