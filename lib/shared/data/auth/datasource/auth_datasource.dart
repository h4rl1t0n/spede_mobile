import 'package:multiple_result/multiple_result.dart';

import '../../../../core/exceptions/failure.dart';
import '../dto/auth_request_dto.dart';
import '../dto/auth_response_dto.dart';

abstract class AuthDatasource {
  Future<Result<AuthResponseDto, Failure>> login({required AuthRequestDto auth});
}
