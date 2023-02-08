import 'package:equatable/equatable.dart';

import '/core/network/network_request.dart';

class RequestDeletePrincipioAtivo extends Equatable implements NetworkRequest {
  final List<Map<String, dynamic>>? idsPrincipiosAtivos;
  // final dynamic idsPrincipiosAtivos;

  const RequestDeletePrincipioAtivo({this.idsPrincipiosAtivos});

  _map() {
    Map<String, dynamic> _maps = <String, dynamic>{};
    if (idsPrincipiosAtivos != null) _maps['ids'] = idsPrincipiosAtivos;
    return _maps;
  }

  @override
  toMap() => _map();

  @override
  List<Object?> get props => [idsPrincipiosAtivos];
}
