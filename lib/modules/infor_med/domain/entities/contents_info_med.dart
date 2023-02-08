import 'package:equatable/equatable.dart';

class ContentsInfoMed extends Equatable {
  final String? id;
  final String? tipo;
  final String? conteudo;
  final String? conteudoHtml;
  final String? titulo;
  final String? descricao;
  final String? url;
  final int? anoPublicacao;
  final int? copyright;
  final int? minutosLeitura;
  final List<String>? autores;

  ContentsInfoMed({
    this.id,
    this.tipo,
    this.anoPublicacao,
    this.copyright,
    this.minutosLeitura,
    this.titulo,
    this.descricao,
    this.url,
    this.autores,
    this.conteudo,
    this.conteudoHtml,
  });

  @override
  List<Object?> get props => [
        this.id,
        this.tipo,
        this.anoPublicacao,
        this.copyright,
        this.minutosLeitura,
        this.titulo,
        this.descricao,
        this.url,
        this.autores,
        this.conteudo,
        this.conteudoHtml,
      ];
}
