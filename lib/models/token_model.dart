class TokenModel {
  final String iss;
  final String sub;
  final int idPessoa;
  final int exp;

  TokenModel({required this.iss, required this.sub, required this.idPessoa, required this.exp});

  factory TokenModel.fromMap(Map<String, dynamic> json) {
    return TokenModel(iss: json['iss'], sub: json['sub'], idPessoa: json['idPessoa'], exp: json['exp']);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iss'] = iss;
    data['sub'] = sub;
    data['idPessoa'] = idPessoa;
    data['exp'] = exp;
    return data;
  }
}
