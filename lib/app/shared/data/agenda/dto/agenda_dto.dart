class AgendaDTO {
  int? id;
  String? titulo;
  String? descricao;
  String? dataAgenda;
  String? visibilidade;
  int? idEscrito;
  String? numeroEscrito;
  String? descricaoEscrito;
  String? tipoEscrito;
  String? orgaoEscrito;
  int? idUsuario;
  String? nomeUsuario;
  // List<Null>? lembretes;
  // List<Null>? usuarios;
  bool? possuiNotificacao;

  AgendaDTO({
    this.id,
    this.titulo,
    this.descricao,
    this.dataAgenda,
    this.visibilidade,
    this.idEscrito,
    this.numeroEscrito,
    this.descricaoEscrito,
    this.tipoEscrito,
    this.orgaoEscrito,
    this.idUsuario,
    this.nomeUsuario,
    // this.lembretes,
    // this.usuarios,
    this.possuiNotificacao,
  });

  AgendaDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    dataAgenda = json['dataAgenda'];
    visibilidade = json['visibilidade'];
    idEscrito = json['idEscrito'];
    numeroEscrito = json['numeroEscrito'];
    descricaoEscrito = json['descricaoEscrito'];
    tipoEscrito = json['tipoEscrito'];
    orgaoEscrito = json['orgaoEscrito'];
    idUsuario = json['idUsuario'];
    nomeUsuario = json['nomeUsuario'];
    // if (json['lembretes'] != null) {
    //   lembretes = <Null>[];
    //   json['lembretes'].forEach((v) {
    //     lembretes!.add(Null.fromJson(v));
    //   });
    // }
    // if (json['usuarios'] != null) {
    //   usuarios = <Null>[];
    //   json['usuarios'].forEach((v) {
    //     usuarios!.add(Null.fromJson(v));
    //   });
    // }
    possuiNotificacao = json['possuiNotificacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['titulo'] = titulo;
    data['descricao'] = descricao;
    data['dataAgenda'] = dataAgenda;
    data['visibilidade'] = visibilidade;
    data['idEscrito'] = idEscrito;
    data['numeroEscrito'] = numeroEscrito;
    data['descricaoEscrito'] = descricaoEscrito;
    data['tipoEscrito'] = tipoEscrito;
    data['orgaoEscrito'] = orgaoEscrito;
    data['idUsuario'] = idUsuario;
    data['nomeUsuario'] = nomeUsuario;
    // if (lembretes != null) {
    //   data['lembretes'] = lembretes!.map((v) => v.toJson()).toList();
    // }
    // if (usuarios != null) {
    //   data['usuarios'] = usuarios!.map((v) => v.toJson()).toList();
    // }
    data['possuiNotificacao'] = possuiNotificacao;
    return data;
  }
}
