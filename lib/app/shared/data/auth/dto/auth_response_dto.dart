class AuthResponseDto {
  int? id;
  String? username;
  String? nome;
  String? email;
  String? cpf;
  int? setor;
  String? nomeSetor;
  int? iat;
  int? exp;

  AuthResponseDto({
    this.id,
    this.username,
    this.nome,
    this.email,
    this.cpf,
    this.setor,
    this.nomeSetor,
    this.iat,
    this.exp,
  });

  AuthResponseDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    nome = json['nome'];
    email = json['email'];
    cpf = json['cpf'];
    setor = json['setor'];
    nomeSetor = json['nomeSetor'];
    iat = json['iat'];
    exp = json['exp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['nome'] = nome;
    data['email'] = email;
    data['cpf'] = cpf;
    data['setor'] = setor;
    data['nomeSetor'] = nomeSetor;
    data['iat'] = iat;
    data['exp'] = exp;
    return data;
  }
}
