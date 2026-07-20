import 'dart:convert';

class AuthRequestDto {
  String login;
  String senha;

  AuthRequestDto({required this.login, required this.senha});

  AuthRequestDto copyWith({String? login, String? senha, String? tipoPerfil}) {
    return AuthRequestDto(login: login ?? this.login, senha: senha ?? this.senha);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'login': login, 'senha': senha};
  }

  factory AuthRequestDto.fromMap(Map<String, dynamic> map) {
    return AuthRequestDto(login: map['login'] as String, senha: map['senha'] as String);
  }

  String toJson() => json.encode(toMap());

  factory AuthRequestDto.fromJson(String source) {
    return AuthRequestDto.fromMap(json.decode(source) as Map<String, dynamic>);
  }
}
