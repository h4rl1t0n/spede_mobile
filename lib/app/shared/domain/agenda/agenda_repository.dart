import 'package:multiple_result/multiple_result.dart';

import '../../../core/exceptions/failure.dart';
import 'entities/agenda_entity.dart';

abstract class AgendaRepository {
  Future<Result<List<AgendaEntity>, Failure>> carregarEventosPorSetor({required int idSetor});
}
