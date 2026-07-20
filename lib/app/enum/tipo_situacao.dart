enum TipoSituacao {
  pendente('Pendente'),
  atendida('Atendida'),
  rejeitada('Rejeitada');

  final String name;
  const TipoSituacao(this.name);
}
