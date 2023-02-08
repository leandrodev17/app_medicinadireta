import 'package:equatable/equatable.dart';

import '/core/network/network_request.dart';

class RequestAttachmentsSave extends Equatable implements NetworkRequest {
  final String? hashArquivo;
  final String? legenda;
  final String? nomeArquivo;
  final String? tipoArquivo;

  RequestAttachmentsSave({
    this.hashArquivo,
    this.legenda,
    this.nomeArquivo,
    this.tipoArquivo,
  });

  _map() {
    Map<String, dynamic> _map = Map<String, dynamic>();
    if (this.hashArquivo != null) _map['hashArquivo'] = this.hashArquivo;
    if (this.legenda != null) _map['legenda'] = this.legenda;
    if (this.nomeArquivo != null) _map['nomeArquivo'] = this.nomeArquivo;
    if (this.tipoArquivo != null) _map['tipoArquivo'] = this.tipoArquivo;

    return _map;
  }

  @override
  toMap() => _map();

  @override
  List<Object> get props => [hashArquivo!, legenda!, nomeArquivo!, tipoArquivo!];
}