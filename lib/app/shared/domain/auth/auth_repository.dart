import 'package:multiple_result/multiple_result.dart';

import '../../../core/exceptions/failure.dart';
import '../../data/auth/dto/auth_request_dto.dart';

abstract class AuthRepository {
  Future<Result<bool, Failure>> login({required AuthRequestDto auth});
}
