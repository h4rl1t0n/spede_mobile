import 'package:multiple_result/multiple_result.dart';

import '../../../core/exceptions/failure.dart';
import '../../data/auth/dto/auth_request_dto.dart';
import '../../domain/auth/auth_repository.dart';

class AuthService {
  final AuthRepository repository;

  AuthService(this.repository);

  Future<Result<String, Failure>> login({required AuthRequestDto auth}) async {
    return repository.login(auth: auth);
  }
}
