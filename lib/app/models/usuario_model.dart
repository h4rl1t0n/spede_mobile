// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UsuarioModel {
  final int id;
  final String username;
  final String nome;
  final String email;
  final String cpf;
  final int idSetor;
  final String nomeSetor;

  const UsuarioModel({
    required this.id,
    required this.username,
    required this.nome,
    required this.email,
    required this.cpf,
    required this.idSetor,
    required this.nomeSetor,
  });

  UsuarioModel copyWith({
    int? id,
    String? username,
    String? nome,
    String? email,
    String? cpf,
    int? idSetor,
    String? nomeSetor,
  }) {
    return UsuarioModel(
      id: id ?? this.id,
      username: username ?? this.username,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      idSetor: idSetor ?? this.idSetor,
      nomeSetor: nomeSetor ?? this.nomeSetor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'nome': nome,
      'email': email,
      'cpf': cpf,
      'idSetor': idSetor,
      'nomeSetor': nomeSetor,
    };
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: map['id'] as int,
      username: map['username'] as String,
      nome: map['nome'] as String,
      email: map['email'] as String,
      cpf: map['cpf'] as String,
      idSetor: map['idSetor'] as int,
      nomeSetor: map['nomeSetor'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromJson(String source) => UsuarioModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String get firstName {
    final nomes = nome.trim().split(RegExp(r'\s+'));

    if (nomes.length == 1) {
      return nomes.first;
    }

    return '${nomes[0]} ${nomes[1]}';
  }

  String get avatar {
    const ignorar = {'de', 'da', 'do', 'dos', 'das'};

    return nome
        .trim()
        .split(RegExp(r'\s+'))
        .where((parte) => !ignorar.contains(parte.toLowerCase()))
        .take(2)
        .map((parte) => parte[0].toUpperCase())
        .join();
  }

  @override
  String toString() {
    return 'UsuarioModel(id: $id, username: $username, nome: $nome, email: $email, cpf: $cpf, idSetor: $idSetor, nomeSetor: $nomeSetor)';
  }
}
