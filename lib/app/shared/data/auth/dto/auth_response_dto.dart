import 'dart:convert';

class AuthResponseDto {
  final String token;
  final String refreshToken;

  AuthResponseDto({required this.token, required this.refreshToken});

  AuthResponseDto copyWith({String? token, String? refreshToken}) {
    return AuthResponseDto(token: token ?? this.token, refreshToken: refreshToken ?? this.refreshToken);
  }

  factory AuthResponseDto.fromMap(Map<String, dynamic> json) {
    return AuthResponseDto(token: json['token'], refreshToken: json['refreshToken']);
  }

  Map<String, dynamic> toMap() => {'token': token, 'refreshToken': refreshToken};

  String toJson() => json.encode(toMap());

  factory AuthResponseDto.fromJson(String source) => AuthResponseDto.fromMap(Map.castFrom(json.decode(source)));
}
