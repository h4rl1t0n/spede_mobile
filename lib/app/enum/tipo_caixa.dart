enum TipoCaixa {
  enviadas('CAIXA_ENVIADAS', 'Solicitações Enviadas'),
  recebidas('CAIXA_RECEBIDAS', 'Solicitações Recebidas');

  final String name;
  final String descricao;
  const TipoCaixa(this.name, this.descricao);
}
