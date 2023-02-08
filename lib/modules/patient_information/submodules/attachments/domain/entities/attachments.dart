import 'package:equatable/equatable.dart';

// Esta model tbem será usada para o retorno do arquivo em base64.
class Attachments extends Equatable {
  final int? id; // Mesmo para o retorno no arquivoBase64 Busca pelo arquivo
  final String? nomeArquivo;
  final String? arquivoBase64; // Mesmo para o retorno no arquivoBase64 Busca pelo arquivo

  final int? pacienteId;
  final int? atendimentoId;
  final int? versaoAtendimento;
  final int? vinculoAtendimento;
  final String? legenda;
  final String? palavrasChave;
  final int? tamanhoArquivo;
  final String? tipoArquivo;
  final String? dataFoto;
  final String? dataInclusao;
  final String? dataAlteracao;
  final String? dataLocal;
  final String? dataUltAcesso;
  final String? dataUtc;
  final String? utcEvento;
  final String? editavel;
  final String? ativado;
  final String? statusAssinatura;
  final String? azure;
  final String? logUsuario;

  Attachments({
    this.id,
    this.pacienteId,
    this.legenda,
    this.palavrasChave,
    this.nomeArquivo,
    this.tamanhoArquivo,
    this.tipoArquivo,
    this.dataFoto,
    this.dataInclusao,
    this.dataAlteracao,
    this.dataLocal,
    this.dataUltAcesso,
    this.dataUtc,
    this.utcEvento,
    this.editavel,
    this.ativado,
    this.statusAssinatura,
    this.azure,
    this.logUsuario,
    this.atendimentoId,
    this.versaoAtendimento,
    this.vinculoAtendimento,
    this.arquivoBase64,
  });

  @override
  List<Object?> get props => [
        this.id,
        this.pacienteId,
        this.legenda,
        this.palavrasChave,
        this.nomeArquivo,
        this.tamanhoArquivo,
        this.tipoArquivo,
        this.dataFoto,
        this.dataInclusao,
        this.dataAlteracao,
        this.dataLocal,
        this.dataUltAcesso,
        this.dataUtc,
        this.utcEvento,
        this.editavel,
        this.ativado,
        this.statusAssinatura,
        this.azure,
        this.logUsuario,
        this.atendimentoId,
        this.versaoAtendimento,
        this.vinculoAtendimento,
        this.arquivoBase64,
      ];
}
