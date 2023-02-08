import 'package:equatable/equatable.dart';

import '/core/network/network_request.dart';

class RequestNewEvolution extends Equatable implements NetworkRequest {
  final String? tussDescricao;
  final String? historico;
  final String? tuss;
  final String? titulo;

  RequestNewEvolution({this.tussDescricao, this.historico, this.tuss, this.titulo});

  _map() {
    Map<String, dynamic> _map = Map<String, dynamic>();
    if (this.tussDescricao != null) _map["tussDescricao"] = this.tussDescricao;
    if (this.historico != null) _map["historico"] = this.historico;
    if (this.tuss != null) _map["tuss"] = this.tuss;
    if (this.titulo != null) _map["titulo"] = this.titulo;
    return _map;
  }

  @override
  toMap() => _map();

  @override
  List<Object> get props => [tussDescricao!, historico!, tuss!, titulo!];

  RequestNewEvolution copyWith({
    String? tussDescricao,
    String? historico,
    String? tuss,
    String? titulo,
  }) {
    return RequestNewEvolution(
      tussDescricao: tussDescricao ?? this.tussDescricao,
      historico: historico ?? this.historico,
      tuss: tuss ?? this.tuss,
      titulo: titulo ?? this.titulo,
    );
  }
}
