abstract class Failure implements Exception {
  String? get message;
  int? get statusCode;
}
