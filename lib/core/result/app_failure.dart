import 'failure.dart';

class AppFailure extends Failure {
  @override
  final String? message;
  @override
  final int? statusCode;
  AppFailure({this.message, this.statusCode});
}
