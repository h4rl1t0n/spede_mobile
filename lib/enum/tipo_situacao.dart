enum TipoSituacao {
  pendente('Pendente'),
  deferida('Deferida'),
  indeferida('Indeferida');

  final String name;
  const TipoSituacao(this.name);
}
