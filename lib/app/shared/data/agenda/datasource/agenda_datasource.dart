import 'package:multiple_result/multiple_result.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../models/lembrete_model.dart';
import '../dto/agenda_dto.dart';

abstract class AgendaDatasource {
  Future<Result<List<LembreteModel>, Failure>> carregarTodosEventos({required DateTime mes, int? idSetor});
  Future<Result<List<AgendaDTO>, Failure>> carregarEventosPorSetor({int? idSetor});
}
