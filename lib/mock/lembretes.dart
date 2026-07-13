import 'package:flutter/material.dart';

import '../models/lembrete_model.dart';

final lembretes = <LembreteModel>[
  LembreteModel(
    id: '1',
    titulo: 'Sessão Plenária Ordinária',
    descricao:
        'Pauta de julgamentos da 15ª Sessão Ordinária do Tribunal Pleno. Apresentação de contas anuais de prefeituras do interior.',
    tipo: 'Sessão',
    numero: '16210/2026',
    assunto: 'Julgamento de Contas',
    orgao: 'Tribunal Pleno',
    data: DateTime(2026, 7, 10),
    cor: Colors.green,
    isLembrete: false,
  ),

  LembreteModel(
    id: '2',
    titulo: 'Vencimento do prazo de resposta da comunicação',
    descricao: 'Comunicação nº 119722, comunicado RAFAELA FARIA GOMES DA SILVA. Prazo de resposta vence hoje.',
    tipo: 'Processo',
    numero: '13931/2026',
    assunto: 'Prestação de Contas Anual',
    orgao: 'Maternidade Balbina Mestrinho',
    data: DateTime(2026, 7, 10),
    cor: Colors.blue, // Azul padronizado no seu print para comunicações
    isLembrete: true,
  ),

  LembreteModel(
    id: '3',
    titulo: 'Audiência de Instrução',
    descricao:
        'Oitiva de testemunhas e responsáveis referentes ao processo de tomada de contas especial instaurado para apurar irregularidades.',
    tipo: 'Audiência',
    numero: '15002/2026',
    assunto: 'Tomada de Contas Especial',
    orgao: 'Secretaria de Estado de Infraestrutura (SEINFRA)',
    data: DateTime(2026, 7, 15),
    cor: Colors.purple,
    isLembrete: false,
  ),

  LembreteModel(
    id: '4',
    titulo: 'Prazo final para Manifestação Técnica',
    descricao:
        'Apresentação de defesa prévia quanto aos indícios de sobrepreço apontados no relatório preliminar de auditoria.',
    tipo: 'Processo',
    numero: '16300/2026',
    assunto: 'Representação',
    orgao: 'Fundo Estadual de Saúde',
    data: DateTime(2026, 7, 15),
    cor: Colors.red,
    isLembrete: true,
  ),

  LembreteModel(
    id: '5',
    titulo: 'Envio de Balancetes Mensais',
    descricao:
        'Prazo limite legal para o envio da documentação contábil e fiscal referente ao mês de junho/2026 através do sistema e-Contas.',
    tipo: 'Obrigação Acessória',
    numero: '16301/2026',
    assunto: 'Acompanhamento Contábil',
    orgao: 'Prefeitura Municipal de Parintins',
    data: DateTime(2026, 7, 15),
    cor: Colors.blue,
    isLembrete: false,
  ),

  LembreteModel(
    id: '6',
    titulo: 'Início de Inspeção Ordinária In Loco',
    descricao:
        'Deslocamento da equipe técnica de auditoria para verificação física das obras de pavimentação do lote 04.',
    tipo: 'Auditoria',
    numero: '17020/2026',
    assunto: 'Auditoria de Conformidade',
    orgao: 'Departamento Estadual de Trânsito (DETRAN-AM)',
    data: DateTime(2026, 7, 18),
    cor: Colors.teal,
    isLembrete: false,
  ),

  LembreteModel(
    id: '7',
    titulo: 'Reunião Técnica com Jurisdicionado',
    descricao:
        'Alinhamento sobre a nova instrução normativa de transição de mandato e encerramento de exercício financeiro.',
    tipo: 'Reunião',
    numero: '17021/2026',
    assunto: 'Orientação Normativa',
    orgao: 'Associação Amazonense de Municípios',
    data: DateTime(2026, 7, 18),
    cor: Colors.indigo,
    isLembrete: false,
  ),

  LembreteModel(
    id: '8',
    titulo: 'Vencimento para Entrega de Relatório Conclusivo',
    descricao:
        'Prazo estipulado para a comissão técnica emitir o laudo de engenharia conclusivo sobre o contrato nº 045/2025.',
    tipo: 'Processo',
    numero: '17100/2026',
    assunto: 'Acompanhamento de Contrato',
    orgao: 'Secretaria de Estado de Educação (SEDUC)',
    data: DateTime(2026, 7, 22),
    cor: Colors.deepOrange,
    isLembrete: true,
  ),

  LembreteModel(
    id: '9',
    titulo: 'Sessão de Julgamento de Recurso',
    descricao:
        'Apreciação de Recurso de Reconsideração interposto contra o Acórdão 342/2025 que julgou irregular as contas.',
    tipo: 'Sessão',
    numero: '17250/2026',
    assunto: 'Recurso de Reconsideração',
    orgao: 'Câmara Municipal de Itacoatiara',
    data: DateTime(2026, 7, 24),
    cor: Colors.deepPurple,
    isLembrete: false,
  ),

  LembreteModel(
    id: '10',
    titulo: 'Baixa e Arquivamento Definitivo',
    descricao:
        'Trânsito em julgado certificado pelo relator. Processo apto para arquivamento definitivo no setor de arquivo geral.',
    tipo: 'Processo',
    numero: '17380/2026',
    assunto: 'Aposentadoria / Pensão',
    orgao: 'Fundo Previdenciário do Estado (AMAZONPREV)',
    data: DateTime(2026, 7, 28),
    cor: Colors.green,
    isLembrete: false,
  ),

  LembreteModel(
    id: '11',
    titulo: 'Publicação de Acórdão no Diário Oficial',
    descricao: 'Data prevista para a disponibilização do Acórdão nº 512/2026 no Diário Oficial Eletrônico (DOE).',
    tipo: 'Publicação',
    numero: '17402/2026',
    assunto: 'Atos de Admissão de Pessoal',
    orgao: 'Polícia Militar do Estado do Amazonas',
    data: DateTime(2026, 7, 30),
    cor: Colors.cyan,
    isLembrete: false,
  ),

  LembreteModel(
    id: '12',
    titulo: 'Vencimento do prazo de Notificação de Multa',
    descricao:
        'Comunicação nº 20988, responsável CARLOS ALBERTO SOUZA. Prazo final para comprovação do recolhimento da multa.',
    tipo: 'Comunicação',
    numero: '17405/2026',
    assunto: 'Cobrança Executiva',
    orgao: 'Secretaria Municipal de Finanças',
    data: DateTime(2026, 7, 30),
    cor: Colors.red,
    isLembrete: true,
  ),

  LembreteModel(
    id: '13',
    titulo: 'Abertura de Prazo para Diligência Complementar',
    descricao:
        'Necessidade urgente de envio das notas fiscais faltantes referentes à execução das metas de março a maio de 2025.',
    tipo: 'Processo',
    numero: '17406/2026',
    assunto: 'Prestação de Contas de Convênio',
    orgao: 'Fundação de Amparo à Pesquisa (FAPEAM)',
    data: DateTime(2026, 7, 30),
    cor: Colors.amber,
    isLembrete: true,
  ),

  LembreteModel(
    id: '14',
    titulo: 'Homologação de Relatório de Auditoria',
    descricao:
        'Aprovação pelo conselheiro relator do relatório final da auditoria especial realizada na folha de pagamento.',
    tipo: 'Processo',
    numero: '17407/2026',
    assunto: 'Auditoria Especial',
    orgao: 'Assembleia Legislativa do Estado',
    data: DateTime(2026, 7, 30),
    cor: Colors.green,
    isLembrete: false,
  ),
];
