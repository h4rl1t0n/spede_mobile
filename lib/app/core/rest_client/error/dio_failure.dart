import '../../exceptions/failure.dart';

class DioFailure extends Failure {
  @override
  final String? message;
  @override
  final int? statusCode;
  DioFailure({
    this.message,
    this.statusCode,
  });
}
