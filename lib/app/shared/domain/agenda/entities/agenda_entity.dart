class AgendaEntity {
  int? id;
  String titulo;
  String descricao;
  DateTime dataAgenda;
  String visibilidade;
  int? idProcesso;
  String numeroProcesso;
  String descricaoProcesso;
  String tipoProcesso;
  String orgaoProcesso;
  int? idUsuario;
  String nomeUsuario;
  bool possuiNotificacao;

  AgendaEntity({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.dataAgenda,
    required this.visibilidade,
    this.idProcesso,
    required this.numeroProcesso,
    required this.descricaoProcesso,
    required this.tipoProcesso,
    required this.orgaoProcesso,
    this.idUsuario,
    required this.nomeUsuario,
    required this.possuiNotificacao,
  });

  AgendaEntity copyWith({
    int? id,
    String? titulo,
    String? descricao,
    DateTime? dataAgenda,
    String? visibilidade,
    int? idProcesso,
    String? numeroProcesso,
    String? descricaoProcesso,
    String? tipoProcesso,
    String? orgaoProcesso,
    int? idUsuario,
    String? nomeUsuario,
    bool? possuiNotificacao,
  }) {
    return AgendaEntity(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      dataAgenda: dataAgenda ?? this.dataAgenda,
      visibilidade: visibilidade ?? this.visibilidade,
      idProcesso: idProcesso ?? this.idProcesso,
      numeroProcesso: numeroProcesso ?? this.numeroProcesso,
      descricaoProcesso: descricaoProcesso ?? this.descricaoProcesso,
      tipoProcesso: tipoProcesso ?? this.tipoProcesso,
      orgaoProcesso: orgaoProcesso ?? this.orgaoProcesso,
      idUsuario: idUsuario ?? this.idUsuario,
      nomeUsuario: nomeUsuario ?? this.nomeUsuario,
      possuiNotificacao: possuiNotificacao ?? this.possuiNotificacao,
    );
  }

  @override
  String toString() {
    return 'AgendaEntity(id: $id, titulo: $titulo, descricao: $descricao, dataAgenda: $dataAgenda, visibilidade: $visibilidade, idProcesso: $idProcesso, numeroProcesso: $numeroProcesso, descricaoProcesso: $descricaoProcesso, tipoProcesso: $tipoProcesso, orgaoProcesso: $orgaoProcesso, idUsuario: $idUsuario, nomeUsuario: $nomeUsuario, possuiNotificacao: $possuiNotificacao)';
  }
}
