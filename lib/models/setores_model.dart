class SetoresModel {
  final int id;
  final String sigla;
  final String nome;

  SetoresModel({required this.id, required this.sigla, required this.nome});

  SetoresModel copyWith({int? id, String? sigla, String? nome}) {
    return SetoresModel(id: id ?? this.id, sigla: sigla ?? this.sigla, nome: nome ?? this.nome);
  }
}
