enum TipoCaixa {
  enviadas('CAIXA_ENVIADAS', 'Solicitações Enviadas'),
  recebidas('CAIXA_RECEBIDAS', 'Solicitações Recebidas');

  final String label;
  final String descricao;
  const TipoCaixa(this.label, this.descricao);
}
