enum TipoDocumento {
  comunicacao('Comunicação'),
  oficio('Ofício'),
  requerimento('Requerimento'),
  notificacao('Notificação'),
  certidao('Certidão'),
  acao('Ação');

  final String name;
  const TipoDocumento(this.name);
}
