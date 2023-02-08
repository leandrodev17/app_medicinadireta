import 'package:medicinadireta/modules/infor_med/domain/entities/contents_info_med.dart';

class ContentsInfoMedExt extends ContentsInfoMed {
  final String? id;
  final String? tipo;
  final String? conteudo;
  final String? conteudoHtml;
  final String? descricao;
  final String? titulo;
  final String? url;
  final int? anoPublicacao;
  final int? copyright;
  final int? minutosLeitura;
  final List<String>? autores;

  ContentsInfoMedExt({
    this.id,
    this.tipo,
    this.anoPublicacao,
    this.copyright,
    this.minutosLeitura,
    this.descricao,
    this.titulo,
    this.url,
    this.autores,
    this.conteudo,
    this.conteudoHtml,
  });

  ContentsInfoMed copyWith({
    String? id,
    String? tipo,
    String? conteudo,
    String? conteudoHtml,
    String? descricao,
    String? titulo,
    String? url,
    int? anoPublicacao,
    int? copyright,
    int? minutosLeitura,
    List<String>? autores,
  }) =>
      ContentsInfoMed(
        id: id ?? this.id,
        tipo: tipo ?? this.tipo,
        anoPublicacao: anoPublicacao ?? this.anoPublicacao,
        copyright: copyright ?? this.copyright,
        minutosLeitura: minutosLeitura ?? this.minutosLeitura,
        descricao: descricao ?? this.descricao,
        titulo: titulo ?? this.titulo,
        url: url ?? this.url,
        autores: autores ?? this.autores,
        conteudo: conteudo ?? this.conteudo,
        conteudoHtml: conteudoHtml ?? this.conteudoHtml,
      );

  factory ContentsInfoMedExt.fromMap(Map<String, dynamic> json) => ContentsInfoMedExt(
        id: json["id"],
        tipo: json["tipo"],
        anoPublicacao: json["anoPublicacao"],
        copyright: json["copyright"],
        minutosLeitura: json["minutosLeitura"],
        descricao: json["descricao"],
        titulo: json["titulo"],
        url: json["url"],
        autores: json["autores"] != null ? List<String>.from(json["autores"].map((d) => d)) : null,
        conteudo: json["conteudo"],
        conteudoHtml: json["conteudoHtml"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "tipo": tipo,
        "anoPublicacao": anoPublicacao,
        "copyright": copyright,
        "minutosLeitura": minutosLeitura,
        "descricao": descricao,
        "titulo": titulo,
        "url": url,
        "autores": autores != null ? List<dynamic>.from(autores!.map((_x) => _x)) : null,
        "conteudo": conteudo,
        "conteudoHtml": conteudoHtml,
      };
}
