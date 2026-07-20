import 'package:multiple_result/multiple_result.dart';

import '../../../../core/exceptions/failure.dart';
import '../dto/auth_request_dto.dart';

abstract class AuthDatasource {
  Future<Result<String, Failure>> login({required AuthRequestDto auth});
}
