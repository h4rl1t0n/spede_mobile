import 'package:flutter/material.dart';

import '../models/calendario.dart';

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
