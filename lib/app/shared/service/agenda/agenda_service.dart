import 'package:multiple_result/multiple_result.dart';

import '../../../core/exceptions/failure.dart';
import '../../../models/lembrete_model.dart';
import '../../data/agenda/dto/agenda_dto.dart';
import '../../domain/agenda/agenda_repository.dart';

class AgendaService {
  final AgendaRepository repository;

  AgendaService(this.repository);

  Future<Result<List<LembreteModel>, Failure>> carregarTodosEventos({required DateTime mes, int? idSetor}) async {
    final result = await repository.carregarTodosEventos(mes: mes, idSetor: idSetor);

    return result.when(
      (success) {
        return Success(success);
      },
      (error) {
        return Error(error);
      },
    );
  }

  Future<Result<List<AgendaDTO>, Failure>> carregarEventosPorSetor({int? idSetor}) async {
    final result = await repository.carregarEventosPorSetor(idSetor: idSetor);

    return result.when(
      (success) {
        return Success(success);
      },
      (error) {
        return Error(error);
      },
    );
  }
}
