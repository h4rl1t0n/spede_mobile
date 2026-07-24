import 'dart:convert';

ErrorResponseDto errorResponseDtoFromJson(String str) => ErrorResponseDto.fromJson(json.decode(str));

String errorResponseDtoToJson(ErrorResponseDto data) => json.encode(data.toJson());

class ErrorResponseDto {
  final List<String> errors;

  ErrorResponseDto({required this.errors});

  factory ErrorResponseDto.fromJson(Map<String, dynamic> json) {
    return ErrorResponseDto(errors: List<String>.from(json['errors'].map((x) => x)));
  }

  Map<String, dynamic> toJson() => {'errors': List<dynamic>.from(errors.map((x) => x))};
}
