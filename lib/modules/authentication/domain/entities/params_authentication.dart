import 'package:equatable/equatable.dart';

import '/core/crypto/crypto.dart';
import '/core/network/network_request.dart';

class ParamsAuthentication extends Equatable implements NetworkRequest {
  final String? login;
  final String? password;

  ParamsAuthentication({this.login, this.password});

  _map() {
    Map<String, dynamic> _p = {'login': this.login, 'senha': Crypto.cryptoString(this.password!)};
    return _p;
  }

  @override
  toMap() => _map();

  @override
  List<Object?> get props => [login, password];

  ParamsAuthentication copyWith({
    String? login,
    String? password,
  }) {
    return ParamsAuthentication(
      login: login ?? this.login,
      password: password ?? this.password,
    );
  }
}
