import 'package:flutter/material.dart';

import '../enum/tipo_documento.dart';
import '../enum/tipo_escrito.dart';
import '../enum/tipo_situacao.dart';
import '../enum/tipo_solicitacao.dart';
import '../models/calendario.dart';
import '../models/documento_model.dart';

final eventos = <Calendario>[
  Calendario(
    id: '5',
    title: 'Sessão Plenária',
    process: '16210/2026',
    category: 'Plenário',
    date: DateTime(2026, 7, 10),
    color: Colors.green,
  ),

  Calendario(
    id: '6',
    title: 'Análise de Prestação de Contas',
    process: '16211/2026',
    category: 'Prestação de Contas',
    date: DateTime(2026, 7, 10),
    color: Colors.orange,
  ),

  Calendario(
    id: '7',
    title: 'Audiência Pública',
    process: '15002/2026',
    category: 'Audiência',
    date: DateTime(2026, 7, 15),
    color: Colors.purple,
  ),

  Calendario(
    id: '8',
    title: 'Prazo para Manifestação',
    process: '16300/2026',
    category: 'Prazo',
    date: DateTime(2026, 7, 15),
    color: Colors.red,
  ),

  Calendario(
    id: '9',
    title: 'Envio de Documentação',
    process: '16301/2026',
    category: 'Documentação',
    date: DateTime(2026, 7, 15),
    color: Colors.blue,
  ),

  Calendario(
    id: '10',
    title: 'Inspeção Ordinária',
    process: '17020/2026',
    category: 'Fiscalização',
    date: DateTime(2026, 7, 18),
    color: Colors.teal,
  ),

  Calendario(
    id: '11',
    title: 'Reunião Técnica',
    process: '17021/2026',
    category: 'Reunião',
    date: DateTime(2026, 7, 18),
    color: Colors.indigo,
  ),

  Calendario(
    id: '12',
    title: 'Entrega de Relatório',
    process: '17100/2026',
    category: 'Relatório',
    date: DateTime(2026, 7, 22),
    color: Colors.deepOrange,
  ),

  Calendario(
    id: '13',
    title: 'Julgamento de Recurso',
    process: '17250/2026',
    category: 'Recurso',
    date: DateTime(2026, 7, 24),
    color: Colors.deepPurple,
  ),

  Calendario(
    id: '14',
    title: 'Encerramento do Processo',
    process: '17380/2026',
    category: 'Processo',
    date: DateTime(2026, 7, 28),
    color: Colors.green,
  ),

  Calendario(
    id: '15',
    title: 'Publicação de Acórdão',
    process: '17402/2026',
    category: 'Acórdão',
    date: DateTime(2026, 7, 30),
    color: Colors.cyan,
  ),

  Calendario(
    id: '16',
    title: 'Notificação ao Responsável',
    process: '17405/2026',
    category: 'Notificação',
    date: DateTime(2026, 7, 30),
    color: Colors.red,
  ),

  Calendario(
    id: '17',
    title: 'Nova Diligência',
    process: '17406/2026',
    category: 'Diligência',
    date: DateTime(2026, 7, 30),
    color: Colors.amber,
  ),

  Calendario(
    id: '18',
    title: 'Auditoria Especial',
    process: '17407/2026',
    category: 'Auditoria',
    date: DateTime(2026, 7, 30),
    color: Colors.green,
  ),
];

final documentos = <DocumentoModel>[
  DocumentoModel(
    id: '5',
    numero: 'OF-12/2026-GP',
    assunto: 'Solicitação de Informações',
    tipoDocumento: TipoDocumento.oficio,
    tipoEscrito: TipoEscrito.documento,
    tipoSituacao: TipoSituacao.pendente,
    tipoSolicitacao: TipoSolicitacao.ciencia,
    remetente: 'GABINETE DA PRESIDÊNCIA',
    destinatario: 'SETIN',
    dias: 3,
    dataSolicitacao: DateTime(2026, 7, 1, 9, 30),
    dataAtendimento: DateTime(2026, 7, 4, 14, 0),
  ),

  DocumentoModel(
    id: '6',
    numero: 'REQ-05/2026-DICAD',
    assunto: 'Aquisição de Equipamentos',
    tipoDocumento: TipoDocumento.requerimento,
    tipoEscrito: TipoEscrito.documento,
    tipoSituacao: TipoSituacao.deferida,
    tipoSolicitacao: TipoSolicitacao.assinatura,
    remetente: 'DICAD',
    destinatario: 'DIPRE',
    dias: 1,
    dataSolicitacao: DateTime(2026, 6, 28, 10, 15),
    dataAtendimento: DateTime(2026, 6, 29, 16, 45),
  ),

  DocumentoModel(
    id: '7',
    numero: 'NT-18/2026-DINFRA',
    assunto: 'Manutenção Preventiva',
    tipoDocumento: TipoDocumento.notificacao,
    tipoEscrito: TipoEscrito.documento,
    tipoSituacao: TipoSituacao.indeferida,
    tipoSolicitacao: TipoSolicitacao.visto,
    remetente: 'DINFRA',
    destinatario: 'SETIN',
    dias: 8,
    dataSolicitacao: DateTime(2026, 6, 20, 8, 0),
    dataAtendimento: DateTime(2026, 6, 28, 11, 20),
  ),

  DocumentoModel(
    id: '8',
    numero: 'COM-25/2026-SECEX',
    assunto: 'Cronograma de Auditoria',
    tipoDocumento: TipoDocumento.comunicacao,
    tipoEscrito: TipoEscrito.rascunho,
    tipoSituacao: TipoSituacao.pendente,
    tipoSolicitacao: TipoSolicitacao.assinatura,
    remetente: 'SECEX',
    destinatario: 'DICAD',
    dias: 0,
    dataSolicitacao: DateTime(2026, 7, 8, 15, 0),
    dataAtendimento: DateTime(2026, 7, 8, 15, 0),
  ),

  DocumentoModel(
    id: '9',
    numero: 'OF-30/2026-SETIN',
    assunto: 'Atualização de Sistemas',
    tipoDocumento: TipoDocumento.oficio,
    tipoEscrito: TipoEscrito.documento,
    tipoSituacao: TipoSituacao.deferida,
    tipoSolicitacao: TipoSolicitacao.ciencia,
    remetente: 'SETIN',
    destinatario: 'DIPLA',
    dias: 2,
    dataSolicitacao: DateTime(2026, 7, 2, 9, 45),
    dataAtendimento: DateTime(2026, 7, 4, 13, 30),
  ),

  DocumentoModel(
    id: '10',
    numero: 'REQ-11/2026-DIPLA',
    assunto: 'Prorrogação de Prazo',
    tipoDocumento: TipoDocumento.requerimento,
    tipoEscrito: TipoEscrito.rascunho,
    tipoSituacao: TipoSituacao.pendente,
    tipoSolicitacao: TipoSolicitacao.visto,
    remetente: 'DIPLA',
    destinatario: 'PRESIDÊNCIA',
    dias: 5,
    dataSolicitacao: DateTime(2026, 6, 30, 11, 10),
    dataAtendimento: DateTime(2026, 7, 5, 17, 0),
  ),

  DocumentoModel(
    id: '11',
    numero: 'COM-41/2026-DICOP',
    assunto: 'Planejamento Anual',
    tipoDocumento: TipoDocumento.comunicacao,
    tipoEscrito: TipoEscrito.documento,
    tipoSituacao: TipoSituacao.deferida,
    tipoSolicitacao: TipoSolicitacao.assinatura,
    remetente: 'DICOP',
    destinatario: 'SETIN',
    dias: 1,
    dataSolicitacao: DateTime(2026, 7, 3, 8, 30),
    dataAtendimento: DateTime(2026, 7, 4, 10, 0),
  ),

  DocumentoModel(
    id: '12',
    numero: 'NT-22/2026-OUVIDORIA',
    assunto: 'Resposta à Manifestação',
    tipoDocumento: TipoDocumento.notificacao,
    tipoEscrito: TipoEscrito.documento,
    tipoSituacao: TipoSituacao.indeferida,
    tipoSolicitacao: TipoSolicitacao.ciencia,
    remetente: 'OUVIDORIA',
    destinatario: 'GABINETE',
    dias: 10,
    dataSolicitacao: DateTime(2026, 6, 15, 14, 0),
    dataAtendimento: DateTime(2026, 6, 25, 9, 15),
  ),

  DocumentoModel(
    id: '13',
    numero: 'OF-45/2026-DIGER',
    assunto: 'Convocação para Reunião',
    tipoDocumento: TipoDocumento.oficio,
    tipoEscrito: TipoEscrito.documento,
    tipoSituacao: TipoSituacao.pendente,
    tipoSolicitacao: TipoSolicitacao.assinatura,
    remetente: 'DIGER',
    destinatario: 'TODAS AS DIRETORIAS',
    dias: 4,
    dataSolicitacao: DateTime(2026, 7, 5, 13, 20),
    dataAtendimento: DateTime(2026, 7, 9, 9, 0),
  ),

  DocumentoModel(
    id: '14',
    numero: 'REQ-19/2026-DGP',
    assunto: 'Capacitação de Servidores',
    tipoDocumento: TipoDocumento.requerimento,
    tipoEscrito: TipoEscrito.documento,
    tipoSituacao: TipoSituacao.deferida,
    tipoSolicitacao: TipoSolicitacao.visto,
    remetente: 'DGP',
    destinatario: 'PRESIDÊNCIA',
    dias: 2,
    dataSolicitacao: DateTime(2026, 7, 1, 8, 45),
    dataAtendimento: DateTime(2026, 7, 3, 16, 10),
  ),

  DocumentoModel(
    id: '15',
    numero: 'COM-52/2026-CONTROLE',
    assunto: 'Prestação de Contas',
    tipoDocumento: TipoDocumento.comunicacao,
    tipoEscrito: TipoEscrito.rascunho,
    tipoSituacao: TipoSituacao.pendente,
    tipoSolicitacao: TipoSolicitacao.ciencia,
    remetente: 'CONTROLE INTERNO',
    destinatario: 'DICAD',
    dias: 6,
    dataSolicitacao: DateTime(2026, 6, 27, 10, 0),
    dataAtendimento: DateTime(2026, 7, 3, 15, 45),
  ),
];
