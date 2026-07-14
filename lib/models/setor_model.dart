import 'dart:convert';

class SetorModel {
  int id;
  String sigla;
  String nome;

  SetorModel({required this.id, required this.sigla, required this.nome});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sigla'] = sigla;
    data['nome'] = nome;
    return data;
  }

  factory SetorModel.fromMap(Map<String, dynamic> json) {
    return SetorModel(id: json['id'], sigla: json['sigla'], nome: json['nome']);
  }

  String toJson() => json.encode(toMap());

  factory SetorModel.fromJson(String source) {
    return SetorModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  SetorModel copyWith({int? id, String? sigla, String? nome}) {
    return SetorModel(id: id ?? this.id, sigla: sigla ?? this.sigla, nome: nome ?? this.nome);
  }
}
