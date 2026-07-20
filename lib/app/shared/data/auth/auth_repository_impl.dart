import 'package:multiple_result/multiple_result.dart';

import '../../../core/exceptions/failure.dart';
import '../../domain/auth/auth_repository.dart';
import 'datasource/auth_datasource.dart';
import 'dto/auth_request_dto.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<Result<String, Failure>> login({required AuthRequestDto auth}) async {
    return datasource.login(auth: auth);
  }
}
