import 'dart:convert';

class UsuarioModel {
  final int id;
  final String nome;
  final String matricula;
  final String cpf;
  final String rg;
  final DateTime? dataNascimento;
  final String sexo;
  final String email;
  final bool interno;
  final bool ativo;

  const UsuarioModel({
    required this.id,
    required this.nome,
    required this.matricula,
    required this.cpf,
    required this.rg,
    this.dataNascimento,
    required this.sexo,
    required this.email,
    required this.interno,
    required this.ativo,
  });

  UsuarioModel copyWith({
    int? id,
    String? nome,
    String? matricula,
    String? cpf,
    String? rg,
    DateTime? dataNascimento,
    String? sexo,
    String? email,
    bool? interno,
    bool? ativo,
  }) {
    return UsuarioModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      matricula: matricula ?? this.matricula,
      cpf: cpf ?? this.cpf,
      rg: rg ?? this.rg,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      sexo: sexo ?? this.sexo,
      email: email ?? this.email,
      interno: interno ?? this.interno,
      ativo: ativo ?? this.ativo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'matricula': matricula,
      'cpf': cpf,
      'rg': rg,
      'dataNascimento': dataNascimento?.millisecondsSinceEpoch,
      'sexo': sexo,
      'email': email,
      'interno': interno,
      'ativo': ativo,
    };
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: map['id'] as int,
      nome: map['nome'] as String,
      matricula: map['matricula'] as String,
      cpf: map['cpf'] as String,
      rg: map['rg'] as String,
      dataNascimento: map['dataNascimento'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dataNascimento'] as int)
          : null,
      sexo: map['sexo'] as String,
      email: map['email'] as String,
      interno: map['interno'] as bool,
      ativo: map['ativo'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromJson(String source) => UsuarioModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String get username {
    return email.split('@').first.toLowerCase();
  }

  String get avatar {
    const ignorar = {'de', 'da', 'do', 'dos', 'das'};

    return nome
        .trim()
        .split(RegExp(r'\s+'))
        .where((parte) => !ignorar.contains(parte.toLowerCase()))
        .take(3)
        .map((parte) => parte[0].toUpperCase())
        .join();
  }
}
