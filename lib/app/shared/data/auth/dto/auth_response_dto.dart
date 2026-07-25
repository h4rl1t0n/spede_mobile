import 'dart:convert';

import '../../../../models/usuario_model.dart';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'nome': nome,
      'email': email,
      'cpf': cpf,
      'setor': setor,
      'nomeSetor': nomeSetor,
      'iat': iat,
      'exp': exp,
    };
  }

  factory AuthResponseDto.fromMap(Map<String, dynamic> map) {
    return AuthResponseDto(
      id: map['id'] != null ? map['id'] as int : null,
      username: map['username'] != null ? map['username'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      setor: map['setor'] != null ? map['setor'] as int : null,
      nomeSetor: map['nomeSetor'] != null ? map['nomeSetor'] as String : null,
      iat: map['iat'] != null ? map['iat'] as int : null,
      exp: map['exp'] != null ? map['exp'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponseDto.fromJson(String source) {
    return AuthResponseDto.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  UsuarioModel toModel() {
    return UsuarioModel(
      id: id ?? 0,
      username: username ?? '',
      nome: nome ?? '',
      email: email ?? '',
      cpf: cpf ?? '',
      idSetor: setor ?? 0,
      nomeSetor: nome ?? '',
    );
  }
}
