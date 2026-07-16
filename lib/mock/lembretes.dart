import '../models/lembrete_model.dart';
import 'setores.dart';

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
    isLembrete: false,
    setorModel: setores[0],
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
    isLembrete: true,
    setorModel: setores[1],
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
    isLembrete: false,
    setorModel: setores[2],
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
    isLembrete: true,
    setorModel: setores[3],
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
    isLembrete: false,
    setorModel: setores[4],
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
    isLembrete: false,
    setorModel: setores[0],
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
    isLembrete: false,
    setorModel: setores[1],
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
    isLembrete: true,
    setorModel: setores[2],
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
    isLembrete: false,
    setorModel: setores[3],
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
    isLembrete: false,
    setorModel: setores[4],
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
    isLembrete: false,
    setorModel: setores[0],
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
    isLembrete: true,
    setorModel: setores[1],
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
    isLembrete: true,
    setorModel: setores[2],
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
    isLembrete: false,
    setorModel: setores[3],
  ),
  LembreteModel(
    id: '15',
    titulo: 'Treinamento Sistema e-Contas',
    descricao:
        'Capacitação obrigatória para novos gestores municipais quanto ao envio de documentação contábil digital.',
    tipo: 'Capacitação',
    numero: '12050/2026',
    assunto: 'Treinamento Técnico',
    orgao: 'Prefeitura Municipal de Tefé',
    data: DateTime(2026, 6, 2),
    isLembrete: false,
    setorModel: setores[4],
  ),

  LembreteModel(
    id: '16',
    titulo: 'Análise de Pregão Eletrônico',
    descricao:
        'Verificação de denúncia sobre supostas irregularidades em certame para aquisição de viaturas policiais.',
    tipo: 'Processo',
    numero: '13105/2026',
    assunto: 'Licitações e Contratos',
    orgao: 'Secretaria de Segurança Pública (SSP-AM)',
    data: DateTime(2026, 6, 5),
    isLembrete: true,
    setorModel: setores[0],
  ),

  LembreteModel(
    id: '17',
    titulo: 'Prazo para Defesa Prévia',
    descricao:
        'Vencimento do prazo legal para o gestor apresentar justificativas quanto às falhas apontadas no controle interno.',
    tipo: 'Processo',
    numero: '13422/2026',
    assunto: 'Denúncia',
    orgao: 'Prefeitura Municipal de Manacapuru',
    data: DateTime(2026, 6, 10),
    isLembrete: true,
    setorModel: setores[1],
  ),

  LembreteModel(
    id: '18',
    titulo: 'Vistoria de Obras In Loco',
    descricao: 'Deslocamento técnico para fiscalização da construção do novo hospital regional do município.',
    tipo: 'Auditoria',
    numero: '14100/2026',
    assunto: 'Auditoria Operacional',
    orgao: 'Secretaria de Estado de Saúde (SES-AM)',
    data: DateTime(2026, 6, 15),
    isLembrete: false,
    setorModel: setores[2],
  ),

  LembreteModel(
    id: '19',
    titulo: 'Aprovação de Edital de Concurso',
    descricao:
        'Sessão para análise e aprovação das regras do novo concurso público para o quadro de professores efetivos.',
    tipo: 'Sessão',
    numero: '14312/2026',
    assunto: 'Atos de Pessoal',
    orgao: 'Universidade do Estado do Amazonas (UEA)',
    data: DateTime(2026, 6, 20),
    isLembrete: false,
    setorModel: setores[3],
  ),

  LembreteModel(
    id: '20',
    titulo: 'Fim do Prazo Recursal',
    descricao:
        'Último dia para interposição de recurso ordinário referente à Tomada de Contas Especial julgada irregular.',
    tipo: 'Prazo',
    numero: '14590/2026',
    assunto: 'Tomada de Contas Especial',
    orgao: 'Prefeitura Municipal de Coari',
    data: DateTime(2026, 6, 22),
    isLembrete: true,
    setorModel: setores[4],
  ),

  LembreteModel(
    id: '21',
    titulo: 'Sessão da 1ª Câmara',
    descricao: 'Pauta exclusiva para julgamento de processos de concessão de aposentadorias, reformas e pensões.',
    tipo: 'Sessão',
    numero: '14705/2026',
    assunto: 'Aposentadoria / Pensão',
    orgao: '1ª Câmara de Julgamento',
    data: DateTime(2026, 6, 25),
    isLembrete: false,
    setorModel: setores[0],
  ),

  LembreteModel(
    id: '22',
    titulo: 'Envio Mensal de Folha de Pagamento',
    descricao: 'Aviso de data limite para a remessa dos dados da folha de pagamento do mês de maio de 2026.',
    tipo: 'Obrigação Acessória',
    numero: '14880/2026',
    assunto: 'Acompanhamento de Pessoal',
    orgao: 'Corpo de Bombeiros Militar do Amazonas',
    data: DateTime(2026, 6, 28),
    isLembrete: true,
    setorModel: setores[1],
  ),

  LembreteModel(
    id: '23',
    titulo: 'Sustentação Oral Confirmada',
    descricao: 'Pedido de sustentação oral deferido pelo relator no processo de prestação de contas anual de 2025.',
    tipo: 'Audiência',
    numero: '18005/2026',
    assunto: 'Julgamento de Contas',
    orgao: 'Câmara Municipal de Manaus',
    data: DateTime(2026, 8, 5),
    isLembrete: false,
    setorModel: setores[2],
  ),

  LembreteModel(
    id: '24',
    titulo: 'Emissão de Relatório Preliminar',
    descricao:
        'Data prevista para a equipe de controle externo finalizar o relatório da auditoria financeira do 1º semestre.',
    tipo: 'Processo',
    numero: '18230/2026',
    assunto: 'Auditoria Financeira',
    orgao: 'Secretaria de Fazenda (SEFAZ)',
    data: DateTime(2026, 8, 8),
    isLembrete: true,
    setorModel: setores[3],
  ),

  LembreteModel(
    id: '25',
    titulo: 'Vencimento de Certidão de Regularidade',
    descricao:
        'A certidão de regularidade fiscal do órgão expira hoje. Necessário regularização de pendências documentais.',
    tipo: 'Aviso',
    numero: '18440/2026',
    assunto: 'Regularidade Fiscal',
    orgao: 'Fundo Estadual de Cultura',
    data: DateTime(2026, 8, 12),
    isLembrete: true,
    setorModel: setores[4],
  ),

  LembreteModel(
    id: '26',
    titulo: 'Notificação de Imputação de Débito',
    descricao:
        'Emissão de notificação para recolhimento aos cofres públicos do montante de R\$ 120.500,00 por dano ao erário.',
    tipo: 'Comunicação',
    numero: '18510/2026',
    assunto: 'Cobrança Executiva',
    orgao: 'Prefeitura Municipal de Tabatinga',
    data: DateTime(2026, 8, 15),
    isLembrete: false,
    setorModel: setores[0],
  ),

  LembreteModel(
    id: '27',
    titulo: 'Instauração de PAD',
    descricao:
        'Acompanhamento de Processo Administrativo Disciplinar instaurado contra servidores por desvio de função.',
    tipo: 'Processo',
    numero: '18700/2026',
    assunto: 'Processo Administrativo Disciplinar',
    orgao: 'Tribunal de Justiça do Amazonas (TJAM)',
    data: DateTime(2026, 8, 20),
    isLembrete: false,
    setorModel: setores[1],
  ),

  LembreteModel(
    id: '28',
    titulo: 'Revisão de Medida Cautelar',
    descricao:
        'Sessão extraordinária para referendar ou revogar medida cautelar de suspensão de pagamento de contrato.',
    tipo: 'Sessão',
    numero: '18882/2026',
    assunto: 'Representação com Pedido de Cautelar',
    orgao: 'Agência Reguladora dos Serviços Públicos (ARSEPAM)',
    data: DateTime(2026, 8, 22),
    isLembrete: true,
    setorModel: setores[2],
  ),

  LembreteModel(
    id: '29',
    titulo: 'Publicação de Pauta de Julgamento',
    descricao:
        'Envio da lista de processos selecionados para a 18ª sessão ordinária para publicação no Diário Oficial.',
    tipo: 'Publicação',
    numero: '19010/2026',
    assunto: 'Pauta de Julgamento',
    orgao: '2ª Câmara de Julgamento',
    data: DateTime(2026, 8, 26),
    isLembrete: false,
    setorModel: setores[3],
  ),

  LembreteModel(
    id: '30',
    titulo: 'Prazo Limite para Transição de Governo',
    descricao:
        'Data final estipulada pela instrução normativa vigente para entrega dos relatórios da comissão de transição.',
    tipo: 'Obrigação Acessória',
    numero: '19200/2026',
    assunto: 'Orientação Normativa',
    orgao: 'Prefeitura Municipal de Maués',
    data: DateTime(2026, 8, 30),
    isLembrete: true,
    setorModel: setores[4],
  ),
];
