import '/core/crypto/crypto.dart';
import '/core/network/network_request.dart';
import 'package:equatable/equatable.dart';

class RequestChangePassword extends Equatable implements NetworkRequest {
  final String novaSenha;
  final String confirmarNovaSenha;
  RequestChangePassword({
    required this.novaSenha,
    required this.confirmarNovaSenha,
  });

  _map() {
    Map<String, dynamic> _p = {
      'novaSenha': Crypto.cryptoString(this.novaSenha),
      'confirmarNovaSenha': Crypto.cryptoString(this.confirmarNovaSenha),
    };
    return _p;
  }

  @override
  toMap() => _map();

  @override
  List<Object> get props => [novaSenha, confirmarNovaSenha];
}
