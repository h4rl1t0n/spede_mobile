import 'package:multiple_result/multiple_result.dart';

import '../../../../core/exceptions/failure.dart';
import '../dto/agenda_dto.dart';

abstract class AgendaDatasource {
  Future<Result<List<AgendaDTO>, Failure>> carregarEventosPorSetor({required int idSetor});
}
