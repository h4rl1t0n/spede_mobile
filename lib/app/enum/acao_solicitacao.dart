enum AcaoSolicitacao {
  atender('Atender'),
  rejeitar('Rejeitar'),
  cancelar('Cancelar');

  final String label;
  const AcaoSolicitacao(this.label);
}
