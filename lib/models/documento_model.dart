import 'package:flutter/material.dart';

import '../enum/tipo_documento.dart';
import '../enum/tipo_escrito.dart';
import '../enum/tipo_situacao.dart';
import '../enum/tipo_solicitacao.dart';

class DocumentoModel {
  final String id;
  final String numero;
  final TipoDocumento tipoDocumento;
  final String assunto;
  final TipoSolicitacao tipoSolicitacao;
  final String remetente;
  final String destinatario;
  final TipoSituacao tipoSituacao;
  final int dias;
  final DateTime dataSolicitacao;
  final DateTime dataAtendimento;
  final TipoEscrito tipoEscrito;

  DocumentoModel({
    required this.id,
    required this.numero,
    required this.tipoDocumento,
    required this.tipoEscrito,
    required this.tipoSolicitacao,
    this.assunto = 'Acompanhamento',
    this.remetente = 'DICAD / HARLITON MARTINS DE SOUZA',
    this.destinatario = 'GERSON CAVALCANTE CRUZ NETO / SETIN',
    this.dias = 6,
    required this.tipoSituacao,
    required this.dataSolicitacao,
    required this.dataAtendimento,
  });

  Widget get image {
    final path = tipoEscrito == .rascunho ? 'assets/images/rascunho_20x20.png' : 'assets/images/documento_20x20.png';
    return Image.asset(path, height: 25, width: 25, fit: BoxFit.contain);
  }

  Color get color => Colors.blue;

  Color corSituacao() {
    return switch (tipoSituacao) {
      TipoSituacao.pendente => Colors.amber.shade900,
      TipoSituacao.deferida => Colors.green.shade900,
      TipoSituacao.indeferida => Colors.red.shade900,
    };
  }
}
