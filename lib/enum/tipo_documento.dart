enum TipoDocumento {
  comunicacao('Comunicação'),
  oficio('Ofício'),
  requerimento('Requerimento'),
  notificacao('Notificação');

  final String name;
  const TipoDocumento(this.name);
}
