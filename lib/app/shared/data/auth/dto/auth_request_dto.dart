import 'dart:convert';

class AuthRequestDto {
  String login;
  String senha;

  AuthRequestDto({required this.login, required this.senha});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'login': login, 'senha': senha};
  }

  String toJson() => json.encode(toMap());

  AuthRequestDto setAuth({String? login, String? senha}) {
    return AuthRequestDto(login: login ?? this.login, senha: senha ?? this.senha);
  }
}
